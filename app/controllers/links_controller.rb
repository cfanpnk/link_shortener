class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
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

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to root_path, notice: 'The short link was updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'The short link was deleted.' }
      format.json { head :no_content }
    end
  end

  def go
    @link = Link.find_by_hash_key!(params[:hash_key])
    redirect_to @link.original_link
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:original_link, :hash_key)
    end

    def invalid_link
      logger.error "Attem to access invalid link #{params[:id]}"
      redirect_to root_path, notice: 'Invalid link'
    end
end
