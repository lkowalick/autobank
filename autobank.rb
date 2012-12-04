#!/usr/bin/env ruby
#The purpose of this program is to automatically generate ledger entries from
#the Chase mobile website.

require 'rubygems'
require 'mechanize'
require 'yaml'

class Transaction
	attr_accessor :payee, :amount

	def initialize(date, payee, amount)
		if date == "Pending"
			@date = date
		else
			@date = Date.strptime(date, '%m/%d/%Y')
		end
		@payee = payee
		@amount = amount
	end

	def date
		if @date == "Pending"
			@date
		else
			@date.strftime("%Y/%m/%d")
		end
	end

	def first_line
		"#{date}\t#{payee}"
	end

	def to_s
		"\n" +
		first_line + "\n" +
		"\tExpenses:Misc\n" +
		"\tAssets:Checking:Chase\t\t\t#{amount}\n"
	end
end
								
#Below is the file that ledger will read, along with the file containing the 
#username and password for login to the Chase website. If these files don't
#exist, the programs exits and reports an error
unless File.file?(ENV['LEDGER_FILE'])
	puts "Need environment variable $LEDGER_FILE to be an actual file"
	exit 1
else
	Ledgerfile = ENV['LEDGER_FILE']
end

has_bank_info = File.file?(ENV['BANK_INFO'])
if has_bank_info
	BankInfo = ENV['BANK_INFO'] if has_bank_info
	chase_info = YAML::load( File.open(BankInfo))["chase"]
end

###########################################################
#	Navigate to Chase Account Information Page
###########################################################

agent = Mechanize.new
agent.user_agent_alias = 'Linux Mozilla'
#Get the Chase mobile sign in page, enter my username, password, and submit the form

agent.get('https://mobilebanking.chase.com/Public/Home/LogOnJp')
form = agent.page.forms[0]
if has_bank_info
	form.auth_userId = chase_info["username"]
	form.auth_passwd = chase_info["password"]
else
	puts "What is your username?"
	form.auth_userId = gets
	puts "What is your password?"
	form.auth_passwd = gets
end
site = agent.submit(form)
puts "Going to Account Page"
############
# Error here: asking for verification
############
site = site.link_with(:text => /CHASE CHECKING/i).click
#Now we begin the parsing of the actual account information page
#First we obtain the page text
page = Nokogiri::HTML(site.body)

# The relevant data is in <td> tags, where the first is garbage, and only the
# 2nd, 4th, and 6th entries contain relevant data

raw_transactions = page.css("td").map(&:text)

raw_transactions.delete_at(-1)

transactions = []
raw_transactions.each_slice(8) do |s| 
	new_trans = Transaction.new(s[3], s[1], s[5])
	transactions << new_trans
end

transactions.delete_if do |trans|
	trans.date == "Pending"
end


#For each transaction taken from the webpage, we check to see if it is in
#the ledger file. We discard it if it already in the ledger file.
#
file_text = File.read(Ledgerfile)
transactions.keep_if do |trans|
	file_text.index(trans.date + "\t" + trans.payee).nil?
end

if transactions.empty?
	puts "No transactions updated"
	exit 0
end

puts "Writing transactions to #{Ledgerfile}"
file = File::open(Ledgerfile, "a")

transactions.reverse
transactions.each do |trans|
		file.puts trans
end
