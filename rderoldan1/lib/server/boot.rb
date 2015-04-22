require_relative 'server'


trap('SIGINT') do
  log("\nTerminating client...")
  Thread.list.each { |t| t.kill }
end

class Boot
  class << self
    def run(*params)
      server = Server.new(params[0])
      server.start
    end
  end
end

if ARGV.size < 1
  puts "Usage: ruby #{__FILE__} [host] [port]"
else
  Boot.run(ARGV[0])
end