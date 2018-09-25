class Admin::LinksController < ApplicationController
  before_action :set_link, only: [:show, :expire]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_link
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_link

  def expire
    @link.update_attribute(:expired, true)
    redirect_to admin_link_path(@link), notice: "The shortened URL has been expired."
  end

  private

    def set_link
      @link = Link.find_by! slug: params[:slug]
    end

    def invalid_link
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      end
    end

    def link_params
      params.require(:link).permit(:original_link, :hash_key, :expired)
    end
end
