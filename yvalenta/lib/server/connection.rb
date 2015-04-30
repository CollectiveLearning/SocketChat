require "securerandom"

class Connection
  attr_accessor :connections

  def initialize
    self.connections = {}
  end

  def add(connection)
    key = generate_key
    connections[key] = connection
    key
  end

  def find(id)
    connections[id]
  end

  def destroy(id)
    connections.delete(id)
  end

  def all
    connections
  end

  def all_except(key)
    connections.select { |k, _| k != key }
  end

  def generate_key
    SecureRandom.uuid
  end
end
