module FpRb
  class Result
    def initialize(value: nil, error: nil)
      raise "error or value must not be nil" if value.nil? && error.nil?
      raise "error and value cannot be set at the same time. \n Error #{error}, Value #{value}" if ! value.nil? && ! error.nil?
      @value = value
      @error = error 
    end

    def with_default(default)
      if @value.nil?
        default
      else
        @value
      end
    end

    def map(&block)
      if @error
        self
      else
        Result.ok(block.(@value))
      end
    end

    def and_then(&block)
      if @error.nil?
        block.(@value)
      else
        self 
      end
    end

    def success?
      !! @value
    end

    def error
      @error
    end

    def self.err(msg)
      Result.new(error: Error.new(msg, Kernel.caller))
    end

    def self.ok(value)
      Result.new(value: value)
    end

    def self.rescue(error_msg = nil, &block)
      begin
        Result.ok(block.())
      rescue StandardError => e
        Result.new(error: Error.new(e.inspect, e.backtrace))
      end
    end

    def map_error(&block)
      if @error
        Result.new(error: block.(@error))
      else
        self 
      end
    end

    class Error
      attr_accessor :msg, :backtrace

      def initialize(msg, backtrace)
        @msg = msg
        @backtrace = backtrace 
      end

      def msg
        @msg
      end

      def details
        <<EOF
ERROR = #{@msg}
Backtrace:
        #{@backtrace.join("\n")}
EOF
      end
    end 
  end
end
