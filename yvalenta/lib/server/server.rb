require 'socket'
require_relative 'connection'

class Server

  attr_accessor :port

  def initialize(port)
    self.port = port
  end

  def run
    puts "Start server"
    Socket.tcp_server_loop(port) do |sock, client_addrinfo|
      Thread.new do
        begin
          id = connections.add(sock)
          sock.puts "Bienvenido!!!!, su id es: #{id}"
          Thread.current[:id] = id
          read
        rescue => e
          p e
          p e.backtrace
        end
      end
    end
  end

  def read
    id = Thread.current[:id]
    sock = connections.find(id)
    while not sock.eof?
      msg = sock.gets
      log "#{id}: #{msg}"
      connections.all_except(id).each { |x, s| s.puts("#{id}: #{msg}") }
    end
  end

  def log(msg)
    puts msg
  end

  def connections
    @connections ||= Connection.new
  end
end
