class ApplicationController < ActionController::API
  def render_json_error(status, error_code)
    render json: ErrorPayload.new(error_code, status), status: status
  end

  def render_json_validation_error(resource, error_code, status = :bad_request)
    render json: ErrorPayload.new(error_code, status,
                                  resource.errors.messages), status: status
  end
end
