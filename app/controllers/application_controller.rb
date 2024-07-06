class ApplicationController < ActionController::API
  include ErrorHandler

  def json_response(data, option = nil)
    response = { success: true, data: data, errors: [] }
    response[:meta_key] = option if option.present?
    render json: response, status: :ok
  end
end
