require 'autobank/transaction'
require 'autobank/parser'
require 'minitest/autorun'

describe Autobank::Parser do
  subject { Autobank::Parser.from_csv(csv_file).first }

  let(:csv_file) { 'spec/fixtures/test.csv' }

  describe "fields" do
    it "sets the date" do
      subject.date.must_equal "2000/01/31"
    end

    it "sets the amount" do
      subject.amount.must_equal "1234.56"
    end

    it "sets the payee" do
      subject.payee.must_equal "Transaction Description 1"
    end
  end
end
