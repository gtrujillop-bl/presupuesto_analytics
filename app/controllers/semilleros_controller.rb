class SemillerosController < ApplicationController
  before_action :set_semillero, only: %i[ show edit update destroy ]
  before_action :set_collection_select, only: %i[ new edit ]

  # GET /semilleros or /semilleros.json
  def index
    @semilleros = Semillero.all
  end

  # GET /semilleros/1 or /semilleros/1.json
  def show
  end

  # GET /semilleros/new
  def new
    @semillero = Semillero.new
  end

  # GET /semilleros/1/edit
  def edit
  end

  # POST /semilleros or /semilleros.json
  def create
    @semillero = Semillero.new(semillero_params)

    respond_to do |format|
      if @semillero.save
        format.html { redirect_to @semillero, notice: "Semillero was successfully created." }
        format.json { render :show, status: :created, location: @semillero }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @semillero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /semilleros/1 or /semilleros/1.json
  def update
    respond_to do |format|
      if @semillero.update(semillero_params)
        format.html { redirect_to @semillero, notice: "Semillero was successfully updated." }
        format.json { render :show, status: :ok, location: @semillero }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @semillero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /semilleros/1 or /semilleros/1.json
  def destroy
    @semillero.destroy
    respond_to do |format|
      format.html { redirect_to semilleros_url, notice: "Semillero was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_semillero
      @semillero = Semillero.find(params[:id])
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_collection_select
      @grupos = Grupo.all
    end

    # Only allow a list of trusted parameters through.
    def semillero_params
      params.require(:semillero).permit(:nombre, :grupo_id, :descripcion)
    end
end
