require 'pocket'

Pocket.configure do |config|
  config.consumer_key = ENV['POCKET_KEY']
end
