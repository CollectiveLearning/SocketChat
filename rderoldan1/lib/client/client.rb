require 'colorize'
require 'socket'
require File.join(File.expand_path(__FILE__), '..', 'message')

class Client
  attr_accessor :ip, :port, :username

  def initialize(ip, port, username)
    self.ip = ip
    self.port = port
    self.username = username
  end

  def start
    read_thread = Thread.new {read}
    read_write = Thread.new {write}

    read_thread.join
    read_write.join
  end

  def read
    begin
      while not socket.eof?
        parse_message socket.gets.chomp
      end
    rescue => e
      log "Exception raised while reading from server: #{e}"
    end
  end

  def write
    begin
      while not STDIN.eof?
        line = Message.build(STDIN.gets.chomp)
         socket.puts line
      end
    end
  end

  def socket
    @socket ||= TCPSocket.new(ip, port)
  end

  def parse_message(msg)
    msg = Message.from_json(msg)
    case msg.code.to_s
      when '100' then send_nickname
      when '200' then p msg.message
    end
  end

  def send_nickname
    msg = Message.new code: '101', message: username
    socket.puts msg.to_json
  end

  def log(str)
    puts str
  end

end
