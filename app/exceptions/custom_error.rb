class CustomError < StandardError
  def initialize(message)
    super(message)
  end
end
