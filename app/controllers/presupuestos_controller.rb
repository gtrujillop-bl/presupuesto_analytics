class PresupuestosController < ApplicationController
  before_action :set_presupuesto, only: %i[ show edit update destroy ]

  # GET /presupuestos or /presupuestos.json
  def index
    @presupuestos = Presupuesto.all
  end

  # GET /presupuestos/1 or /presupuestos/1.json
  def show
  end

  # GET /presupuestos/new
  def new
    @presupuesto = Presupuesto.new
  end

  # GET /presupuestos/1/edit
  def edit
  end

  # POST /presupuestos or /presupuestos.json
  def create
    @presupuesto = Presupuesto.new(presupuesto_params)

    respond_to do |format|
      if @presupuesto.save
        format.html { redirect_to @presupuesto, notice: "Presupuesto was successfully created." }
        format.json { render :show, status: :created, location: @presupuesto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @presupuesto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presupuestos/1 or /presupuestos/1.json
  def update
    respond_to do |format|
      if @presupuesto.update(presupuesto_params)
        format.html { redirect_to @presupuesto, notice: "Presupuesto was successfully updated." }
        format.json { render :show, status: :ok, location: @presupuesto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @presupuesto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presupuestos/1 or /presupuestos/1.json
  def destroy
    @presupuesto.destroy
    respond_to do |format|
      format.html { redirect_to presupuestos_url, notice: "Presupuesto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presupuesto
      @presupuesto = Presupuesto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def presupuesto_params
      params.require(:presupuesto).permit(:rubro_id, :proyecto_id, :valor_inicial, :disponibilidad, :descripcion, :egreso, :reserva)
    end
end
