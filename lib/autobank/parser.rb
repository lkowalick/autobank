module Autobank
  module Parser
    def self.parse(page)
      raw_transactions = page.css("td").map(&:text)

      raw_transactions.delete_at(-1)

      transactions = []
      raw_transactions.each_slice(8) do |s|
        # The relevant data is in <td> tags, where the first is garbage, and
        # only the 2nd, 4th, and 6th entries contain relevant data
        new_trans = Autobank::Transaction.new(s[3], s[1], s[5])
        transactions << new_trans
      end

      transactions.delete_if do |trans|
        trans.date == "Pending"
      end

      transactions
    end
  end
end
