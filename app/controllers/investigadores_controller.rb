class InvestigadoresController < ApplicationController
  before_action :set_investigador, only: %i[ show edit update destroy ]

  # GET /investigadors or /investigadors.json
  def index
    @investigadores = Investigador.all
  end

  # GET /investigadors/1 or /investigadors/1.json
  def show
  end

  # GET /investigadors/new
  def new
    @investigador = Investigador.new
  end

  # GET /investigadors/1/edit
  def edit
  end

  # POST /investigadors or /investigadors.json
  def create
    @investigador = Investigador.new(investigador_params)

    respond_to do |format|
      if @investigador.save
        format.html { redirect_to investigadore_path(@investigador), notice: "Investigador was successfully created." }
        format.json { render :show, status: :created, location: @investigador }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investigador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investigadors/1 or /investigadors/1.json
  def update
    respond_to do |format|
      if @investigador.update(investigador_params)
        format.html { redirect_to investigadore_path(@investigador), notice: "Investigador was successfully updated." }
        format.json { render :show, status: :ok, location: @investigador }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investigador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investigadors/1 or /investigadors/1.json
  def destroy
    @investigador.destroy
    respond_to do |format|
      format.html { redirect_to investigadores_url, notice: "Investigador was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investigador
      @investigador = Investigador.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def investigador_params
      params.require(:investigador).permit(:cedula, :nombres, :apellidos)
    end
end
