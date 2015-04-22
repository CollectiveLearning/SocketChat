require_relative 'client'

trap('SIGINT') do
  log("\nTerminating client...")
  Thread.list.each { |t| t.kill }
end

class Boot
  class << self
    def run(*params)
      username = STDIN.gets.chomp
      client = Client.new(params[0], params[1].to_i, username)
      client.start
    end
  end
end

if ARGV.size < 1
  puts "Usage: ruby #{__FILE__} [host] [port]"
else
  Boot.run(*ARGV)
end