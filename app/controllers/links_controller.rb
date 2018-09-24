class LinksController < ApplicationController
  before_action :set_link
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_link
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_link

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.build_stat

    if @link.save
      redirect_to @link
    else
      redirect_to root_path, notice: "Invalid URL. Please try again." 
    end
  end

  def go
    @link = Link.find_by_hash_key!(params[:hash_key])
    if @link.expired
      render_404
    else
      stat = @link.stat
      stat.increase_counter
      redirect_to @link.original_link
    end
  end

  private

    def set_link
      @link = Link.find_by slug: params[:slug]
    end

    def link_params
      params.require(:link).permit(:original_link, :hash_key, :expired)
    end

    def invalid_link
      logger.error "Attempt to access invalid link #{params[:slug]}"
      redirect_to root_path, notice: 'Invalid link'
    end

    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      end
    end
end
