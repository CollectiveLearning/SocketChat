require 'colorize'
require 'socket'
require_relative 'message'
require_relative 'connection'

class Server
  attr_accessor :port

  def initialize(port)
    self.port = port
  end

  def start
    log "Start chat service. Listening in port #{port}"
    Socket.tcp_server_loop(port) do |sock, client_info|
      Thread.new do
        log 'New connection opened'
        Thread.current[:sock] = sock
        ask_for_username
        read
      end
    end
  end

  def read
    sock = Thread.current[:sock]
    begin
      while not sock.eof?
        line = sock.gets.chomp
        log line
        parse_message line

      end
    rescue => e
      log "Exception raised while reading from server: #{e}"
    end
  end

  def parse_message(msg)
    msg = Message.from_json(msg)
    case msg.code.to_s
      when '101' then receive_nickname(msg)
      when '102' then user_list
      when '200' then public_msg(msg)
      when '300' then help_msg
    end
  end

  def ask_for_username
    sock = Thread.current[:sock]
    msg = Message.new(code: 100, message: 'Hello, write your username please.')
    sock.puts msg.to_json
  end

  def receive_nickname(msg)
    connection.add(msg.message, Thread.current[:sock])
  end

  def user_list
    sock = Thread.current[:sock]
    connection.all.each do |nickname, conn|
      msg = Message.new(code: 200, message: nickname).to_json
      sock.puts msg
    end
  end

  def public_msg(msg)
    p msg
    connection.all.each do |_, conn|
      conn.puts msg.to_json
    end
  end

  def help_msg
    sock = Thread.current[:sock]
    msg = Message.new(code: 200, message: 'This is a very helpful command.')
    sock.puts(msg.to_json)
  end

  def log(str)
    puts str
  end

  def socket
    @socket ||= TCPSocket.new(ip, port)
  end

  def connection
    @connection ||= Connection.new
  end
end
