class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy show redirect ]

  def index
    raise ActionController::RoutingError.new('Not Found')
  end

  def redirect
    if @link.active
      @link.increment!(:view_count)
      redirect_to @link.url
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  
  def show
  end

  def new
    @link = Link.new
  end

  def edit
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    @link.active = true # make link active by default
    @link.admin_id = SecureRandom.uuid

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_admin_path(@link.admin_id), notice: "Link was successfully created." }
        # format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)

        format.html { redirect_to link_admin_path(@link.admin_id), notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to new_link_url, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      if params[:id]
        # raise ActionController::RoutingError.new('Not Found')
        @link = Link.find_by_admin_id(params[:id])
      elsif params[:uuid]
        @link = Link.find_by_admin_id(params[:uuid])
      elsif params[:hash_id]
        id = Hashid.decode(params[:hash_id]).first #first is required otherwise array is returned
        @link = Link.find(id)
      end
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:id, :url, :admin_id, :hash_id, :active, :view_count)
    end
end




























