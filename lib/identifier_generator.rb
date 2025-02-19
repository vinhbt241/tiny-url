# frozen_string_literal: true

class IdentifierGenerator
  # Jan 01, 2025, 01:01:01:000 UTC
  EPOCH = 1_737_680_461_000
  # 10-bit machine ID limit (2^10 - 1)
  MAX_MACHINE_ID = 1023
  # 12-bit sequence limit (2^12 - 1)
  MAX_SEQUENCE = 4095

  @last_timestamp = -1
  @sequence = 0
  @mutex = Mutex.new

  class << self
    def generate_identifier
      unique_number = generate_unique_number
      Base62.encode(unique_number)
    end

    private

    def current_millis
      (Time.current.to_f * 1000).to_i
    end

    def sleep_until_next_millis(last_timestamp)
      while current_millis <= last_timestamp
        sleep(0.001) # Sleep for 1ms
      end
    end

    def generate_unique_number
      @mutex.synchronize do
        timestamp = current_millis

        if timestamp == @last_timestamp
          @sequence += 1
          if @sequence > MAX_SEQUENCE
            # Wait for the next millisecond if sequence is exhausted
            sleep_until_next_millis(timestamp)
            timestamp = current_millis
            @sequence = 0
          end
        else
          @sequence = 0
        end

        @last_timestamp = timestamp

        ((timestamp - EPOCH) << 22) | (machine_id << 12) | @sequence
      end
    end

    def machine_id
      mid = ENV.fetch('MACHINE_ID', 1).to_i
      return 1 if mid.nil? || mid.negative?

      [mid, MAX_MACHINE_ID].min
    end
  end
end
