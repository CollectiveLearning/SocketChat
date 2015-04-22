require 'securerandom'
class Connection

  def initialize
    @connections = {}
  end

  def all
    @connections
  end

  def add(key, connection)
    @connections[key] = connection
  end

  def delete(key)
    @connections.delete(key)
  end

  def delete_at_value(value)
    delete(@connections.key(value))
  end

  def generate_key
    SecureRandom.uuid.gsub '-'
  end
end