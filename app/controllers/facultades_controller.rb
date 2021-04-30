class FacultadesController < ApplicationController
  before_action :set_facultad, only: %i[ show edit update destroy ]

  # GET /facultads or /facultads.json
  def index
    @facultades = Facultad.all
  end

  # GET /facultads/1 or /facultads/1.json
  def show
  end

  # GET /facultads/new
  def new
    @facultad = Facultad.new
  end

  # GET /facultads/1/edit
  def edit
  end

  # POST /facultads or /facultads.json
  def create
    @facultad = Facultad.new(facultad_params)

    respond_to do |format|
      if @facultad.save
        format.html { redirect_to @facultad, notice: "Facultad was successfully created." }
        format.json { render :show, status: :created, location: @facultad }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facultad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facultads/1 or /facultads/1.json
  def update
    respond_to do |format|
      if @facultad.update(facultad_params)
        format.html { redirect_to @facultad, notice: "Facultad was successfully updated." }
        format.json { render :show, status: :ok, location: @facultad }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facultad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facultads/1 or /facultads/1.json
  def destroy
    @facultad.destroy
    respond_to do |format|
      format.html { redirect_to facultades_url, notice: "Facultad was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facultad
      @facultad = Facultad.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facultad_params
      params.require(:facultad).permit(:nombre)
    end
end
