# frozen_string_literal: true

module Rack
  class Attack
    throttle('encode/ip', limit: 20, period: 1.minute) do |req|
      req.ip if req.path == '/encode' && req.post?
    end

    throttle('decode/ip', limit: 100, period: 1.minute) do |req|
      req.ip if req.path == '/decode' && req.get?
    end

    cache.store = ActiveSupport::Cache::MemoryStore.new if !ENV['REDIS_URL'] || Rails.env.test?
  end
end
