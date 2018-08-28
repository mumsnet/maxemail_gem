class MaxemailApiResponse
  attr_accessor :data

  def initialize(data:, success:, message:)
    @data = data
    @data[:success] = success
    @data[:message] = message
  end

  def to_json
    {
      data: @data
    }.to_json
  end

  def successful?
    @data[:success]
  end

  def message
    @data[:message]
  end
end
