class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_404

  private

  def return_500
    render plain: { error: 'Error 500' }.to_json, status: 500, content_type: 'application/json'
  end

  def return_404
    render plain: { error: 'Error 404' }.to_json, status: 404, content_type: 'application/json'
  end
end
