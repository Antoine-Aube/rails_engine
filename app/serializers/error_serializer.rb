class ErrorSerializer

  def initialize(error)
    @error_object = error
  end

  def serialize_json
    {
      errors: [
        {
          title: @error_object.message,
          status: @error_object.status.to_s
        }
      ]
    }
  end
end