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

  def missing_template_id?
    @data[:message].present? && @data[:message].include?('Could not find any approved triggered emails in folder')
  end

  def message
    @data[:message]
  end
end
