require 'autobank/parser/from_csv'
require 'autobank/parser/from_webpage'

module Autobank
  module Parser
    class << self
      alias_method :parse, :parse_from_webpage
    end
  end
end
