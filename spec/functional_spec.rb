require 'autobank'
require 'minitest/autorun'
require 'pry'

describe 'Executable' do
  subject { `bundle exec autobank fixtures/test.csv` }

  it "does NOT blow up" do
    subject
  end
end
