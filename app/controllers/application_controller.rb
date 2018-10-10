class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    render_json_error :not_found, :job_not_found
  end

  def render_json_error(status, error_code)
    render json: ErrorPayload.new(error_code, status), status: status
  end

  def render_json_validation_error(resource, error_code, status = :bad_request)
    render json: ErrorPayload.new(error_code, status,
                                  resource.errors.messages), status: status
  end
end
