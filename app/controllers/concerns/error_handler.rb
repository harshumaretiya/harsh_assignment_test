module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from CustomError, with: :handle_custom_error
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from ActiveRecord::RecordNotUnique, with: :handle_record_not_unique
  end

  private

  def handle_custom_error(exception)
    render json: { success: false, errors: [{ title: 'Custom Error', detail: exception.message }] }, status: :unprocessable_entity
  end

  def handle_record_not_found
    render json: { success: false, errors: [{ title: 'Record Not Found', detail: 'The record you are looking for could not be found.' }] }, status: :not_found
  end

  def handle_record_invalid(exception)
    render json: { success: false, errors: [{ title: 'Validation Error', detail: exception.record.errors.full_messages.join(', ') }] }, status: :unprocessable_entity
  end

  def handle_record_not_unique(exception)
    render json: { success: false, errors: [{ title: 'Duplicate Record Error', detail: 'Email has already been taken' }] }, status: :unprocessable_entity
  end
end
