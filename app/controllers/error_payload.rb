class ErrorPayload
  attr_reader :identifier, :status, :messages

  def initialize(identifier, status, messages = nil)
    @identifier = identifier
    @status = status
    @messages = messages
  end

  def as_json(*)
    error = {
      status: Rack::Utils.status_code(status),
      title: translate_error_messages[:title],
      detail: translate_error_messages[:detail]
    }
    error = error.merge(messages: @messages) if @messages
    error
  end

  private

  def translate_error_messages
    I18n.translate("error_messages.#{@identifier}")
  end
end
