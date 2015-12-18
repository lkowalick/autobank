require 'csv'

module Autobank
  module Parser
    def self.parse(csv)
      CSV.parse(csv, headers: true, header_converters: :symbol).map do |row|
        amount = row[:amount].gsub(/\A(-?)(\d)/, '\1$\2')
        Autobank::Transaction.new(date: row[:post_date],
                                  payee: row[:description],
                                  amount: amount)
      end
    end
  end
end
