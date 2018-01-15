# frozen_string_literal: true

# Api gateway to wiki
module Wiki::Api
  include HTTParty
  logger Rails.logger
  raise_on [*400..431, *500..511]
  base_uri 'https://hades-star.wikia.com/wiki'
end
