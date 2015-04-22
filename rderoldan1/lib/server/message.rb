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
  end
end