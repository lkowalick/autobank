module Autobank
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
end
