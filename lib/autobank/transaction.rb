require 'date'

module Autobank
  class Transaction
    attr_accessor :payee, :amount

    def initialize(date:, payee:, amount:)
      @date = ::Date.strptime(date, '%m/%d/%Y')
      @payee = payee
      @amount = amount
    end

    def date
      @date.strftime("%Y/%m/%d")
    end

    def to_s
      "\n#{first_line}\n    Expenses:AUTOGENERATED\n#{amount_line}"
    end

    private

    def first_line
      "#{date} #{payee}"
    end

    def amount_line
      "    Assets:Checking:Chase#{amount.rjust(27)}\n"
    end
  end
end
