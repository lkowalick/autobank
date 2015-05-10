require 'csv'

module Autobank
  module Parser
    class << self
      def from_csv(filename)
        csv(filename).map do |row|
          Transaction.new(row['Post Date'], row['Description'], row['Amount'])
        end
      end

      private

      def csv(filename)
        CSV.read(filename, headers: true)
      end
    end
  end
end
