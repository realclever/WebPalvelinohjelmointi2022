class StylesController < ApplicationController
  before_action :set_style, only: %i[show edit update destroy]
  before_action :ensure_that_is_admin, only: [:destroy]

  # GET /users or /users.jso
  def index
    @styles = Style.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @style = Style.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @style = Style.new(styles_params)

    respond_to do |format|
      if @style.save
        format.html { redirect_to styles_path, notice: "Style was successfully created." }
        format.json { render :show, status: :created, location: @style }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_style
    @style = Style.find(params[:id])
  end

  def destroy
    style = Style.find params[:id]
    style.delete
    respond_to do |format|
      format.html { redirect_to styles_path(current_user), notice: "Style was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Only allow a list of trusted parameters through.
  def styles_params
    params.require(:style).permit(:name, :description)
  end
end
