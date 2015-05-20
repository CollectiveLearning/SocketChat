#!/usr/bin/env ruby -w
require "socket"
class Server
  def initialize(ip = "localhost", port = 3000)
    @server = TCPServer.open(ip, port)
    @connections = Hash.new
    @rooms = Hash.new
    @clients = Hash.new
    @connections[:server] = @server
    @connections[:rooms] = @rooms
    @connections[:clients] = @clients
    run
  end

  def run
    loop do
      Thread.start(@server.accept) do |client|
        nick_name = register_users(client)
        listen_user_messages(nick_name, client)
      end
    end.join
  end

  def register_users(client)
    nick_name = client.gets.chomp.to_sym
    @connections[:clients].each do |other_name, other_client|
      if nick_name == other_name || client == other_client
        client.puts "This username already exist"
        Thread.kill self
      end
    end
    puts "#{nick_name} #{client}"
    @connections[:clients][nick_name] = client
    client.puts "Connection established, Thank you for joining!"
    nick_name
  end

  def listen_user_messages(username, client)
    loop do
      msg = client.gets.chomp
      @connections[:clients].each do |other_name, other_client|
        unless other_name == username
          other_client.puts "#{username}: #{msg}"
        end
      end
    end
  end
end

args = ARGV.map(&:to_i)
Server.new(*args)
