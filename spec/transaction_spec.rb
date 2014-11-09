require 'autobank/transaction'
require 'minitest/autorun'

describe Autobank::Transaction do
  subject { Autobank::Transaction.new(date_string, payee, amount) }
  let(:date_string) { "Pending" }
  let(:payee) { "Payee" }
  let(:amount) { "$5.00" }

  describe "#date" do
    describe "date_string is 'Pending'" do
      let(:date_string) { "Pending" }

      it "returns 'Pending'" do
        subject.date.must_equal "Pending"
      end
    end

    describe "date_string is MM/DD/YYYY" do
      let(:date_string) { "12/30/2014" }

      it "returns YYYY/MM/DD" do
        subject.date.must_equal "2014/12/30"
      end
    end
  end

  describe "#to_s" do
    it "produces a proper format" do
      subject.to_s.must_equal <<-EOS

Pending\tPayee
\tExpenses:AUTOGENERATED
\tAssets:Checking:Chase\t\t\t$5.00
      EOS
    end
  end
end
