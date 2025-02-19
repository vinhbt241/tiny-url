# frozen_string_literal: true

class Base62
  CHARSET = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.chars.freeze

  def self.encode_int(number)
    return CHARSET[0] if number.zero?

    base62 = ''
    while number.positive?
      remainder = number % 62
      base62 = CHARSET[remainder] + base62
      number /= 62
    end
    base62
  end
end
