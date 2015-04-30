require 'rspec'

require_relative '../lib/client/client'
require_relative '../lib/server/server'
require_relative '../lib/server/connection'


RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end
