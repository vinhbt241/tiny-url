# frozen_string_literal: true

module Rack
  class Attack
    throttle('req/ip', limit: 300, period: 5.minutes, &:ip)

    cache.store = ActiveSupport::Cache::MemoryStore.new if !ENV['REDIS_URL'] || Rails.env.test?
  end
end
