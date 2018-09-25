class LinksController < ApplicationController
  before_action :set_link, only: [:show]
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

  def forward
    hash_key = params[:hash_key]
    @link = Link.fetch_unexpired_link(hash_key)
    @link.stat.increment_counter(hash_key)

    redirect_to @link.original_link, status: :moved_permanently
  end

  private

    def set_link
      @link = Link.find_by! slug: params[:slug]
    end

    def link_params
      params.require(:link).permit(:original_link, :hash_key, :expired)
    end

end
