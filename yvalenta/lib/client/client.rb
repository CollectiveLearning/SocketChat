require "socket"

class Client
  attr_accessor :address, :port

  def initialize(address, port)
    self.address = address
    self.port = port
  end

  def run
    threads = [Thread.new { read }, Thread.new { write }]
    threads.each(&:join)
  end

  def read
    while not socket.eof?
      line = socket.gets
      puts line.chop
    end
  end

  def write
    while not STDIN.eof?
      line = gets.chomp
      socket.puts(line)
    end
  end

  def socket
    @socket ||= TCPSocket.open(address, port)
  end
end
