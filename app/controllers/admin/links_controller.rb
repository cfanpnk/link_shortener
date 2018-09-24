class Admin::LinksController < ApplicationController
  before_action :set_link, only: [:show, :update]

  def show
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to root_path, notice: 'The short link has been expired.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :show }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_link
      @link = Link.find_by slug: params[:slug]
    end

    def link_params
      params.require(:link).permit(:original_link, :hash_key, :expired)
    end
end
