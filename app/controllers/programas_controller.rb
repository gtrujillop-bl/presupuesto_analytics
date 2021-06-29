class ProgramasController < ApplicationController
  before_action :set_programa, only: %i[ show edit update destroy ]
  before_action :set_collection_select, only: %i[ new edit ]

  # GET /grupos or /grupos.json
  def index
    @programas = Programa.all
  end

  # GET /grupos/1 or /grupos/1.json
  def show
  end

  # GET /grupos/new
  def new
    @programa = Programa.new
  end

  # GET /grupos/1/edit
  def edit
  end

  # POST /grupos or /grupos.json
  def create
    @programa = Programa.new(programa_params)

    respond_to do |format|
      if @programa.save
        format.html { redirect_to @programa, notice: "Programa fue creado correctamente." }
        format.json { render :show, status: :created, location: @programa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @programa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programas/1 or /programas/1.json
  def update
    respond_to do |format|
      if @programa.update(programa_params)
        format.html { redirect_to @programa, notice: "programa actualizado correctamente." }
        format.json { render :show, status: :ok, location: @programa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @programa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programas/1 or /programas/1.json
  def destroy
    @programa.destroy
    respond_to do |format|
      format.html { redirect_to grupos_url, notice: "Programa ha sido borrado." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_programa
      @programa = Programa.find(params[:id])
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_collection_select
      @facultades = Facultad.all
    end

    # Only allow a list of trusted parameters through.
    def programa_params
      params.require(:programa).permit(:nombre, :facultades_id)
    end
end
