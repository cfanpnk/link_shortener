class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  protected

  def invalid_link
    render :json => {error: "The link doesn't exist."}, :status => :not_found
  end

end
