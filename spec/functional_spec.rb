require 'autobank'
require 'minitest/autorun'

describe 'Executable' do
  subject { `bundle exec autobank spec/fixtures/test.csv` }

  describe 'the first transaction' do
    let(:result) do
      [
        "\n",
        "2010/12/13 TRANSACTION AT LINE 4\n",
        "    Expenses:AUTOGENERATED\n",
        "    Assets:Checking:Chase                     -$1.00\n",
      ]
    end

    let(:first_transaction) do
      subject.each_line.to_a[0..3]
    end

    it "makes the correct first transaction" do
      first_transaction.must_equal result
    end
  end
end
