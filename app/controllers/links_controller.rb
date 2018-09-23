class LinksController < ApplicationController
  before_action :set_link, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_link
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_link
  # GET /links
  # GET /links.json
  def index
    @link = Link.new
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'A new short link was created.' }
        format.json { render :show, status: :created, location: @link }
      else
        puts @link.errors.full_messages
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def go
    @link = Link.find_by_hash_key!(params[:hash_key])
    if @link.expired
      render_404
    else
      redirect_to @link.original_link
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:original_link, :hash_key, :expired)
    end

    def invalid_link
      logger.error "Attem to access invalid link #{params[:id]}"
      redirect_to root_path, notice: 'Invalid link'
    end

    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      end
    end
end
