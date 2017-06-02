class Maybe
  def initialize(value)
    @value = value
  end

  def with_default(default)
    @value.nil? ? default : @value 
  end

  def map(&block)
    if @value.nil? 
      Maybe.new(block.(@value))
    else
      self
    end
  end

  def present?
    !! @value.nil?
  end

  def blank?
    !! @value.nil?
  end

  def to_result(error)
    if @value
      Result.ok(value)
    else
      Result.err(error)
    end
  end
end
