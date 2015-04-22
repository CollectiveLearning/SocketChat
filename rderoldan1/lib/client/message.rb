require 'active_support/all'
class Message

  CODES = %w(100 101 102 200 201 300)
  attr_accessor :code, :message
  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set "@#{key}", value
    end
  end

  def valid_code?
    CODES.include?(code.to_s)
  end


  class << self
    def from_json(json)
      new(JSON.parse(json))
    end

    def build(msg)
      new(code: gess_code(msg), message: msg).to_json
    end

    def gess_code(msg)
      case
        when msg =~ /\/help(.*)/ then 300
        when msg =~ /\/list(.*)/ then 102

        else
          200
    end
    end
  end
end