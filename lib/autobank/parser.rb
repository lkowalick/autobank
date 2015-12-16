require 'csv'

module Autobank
  module Parser
    def self.parse(csv)
      CSV.parse(csv, headers: true, header_converters: :symbol).map do |row|
        amount = row[:amount].gsub(/\A(-?)(\d)/, '\1$\2')
        Autobank::Transaction.new(row[:post_date], row[:description], amount)
      end
    end
  end
end
