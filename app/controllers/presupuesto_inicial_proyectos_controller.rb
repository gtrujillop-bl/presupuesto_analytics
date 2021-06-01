class PresupuestoInicialProyectosController < ApplicationController
  include Pagy::Backend
  before_action :set_presupuesto_inicial_proyecto, only: %i[ show edit update destroy ]
  before_action :set_collection_select, only: %i[ new edit ]
  rescue_from ActiveRecord::ActiveRecordError, with: :show_errors

  # GET /presupuesto_inicial_proyectos or /presupuesto_inicial_proyectos.json
  def index
    if params[:ids].present?
      @pagy, @presupuestos = pagy(PresupuestoInicialProyecto.where(id: params[:ids]))
      totales = PresupuestoInicialProyecto.where(id: params[:ids])
      calc_totals(totales)
    else
      @pagy, @presupuesto_inicial_proyectos = pagy(PresupuestoInicialProyecto.all)
      totales = PresupuestoInicialProyecto.all
      calc_totals(totales)
    end
  end

  # GET /presupuesto_inicial_proyectos/1 or /presupuesto_inicial_proyectos/1.json
  def show
  end

  # GET /presupuesto_inicial_proyectos/new
  def new
    @presupuesto_inicial_proyecto = PresupuestoInicialProyecto.new
  end

  # GET /presupuesto_inicial_proyectos/1/edit
  def edit
  end

  # POST /presupuesto_inicial_proyectos or /presupuesto_inicial_proyectos.json
  def create
    @presupuesto_inicial_proyecto = PresupuestoInicialProyecto.new(presupuesto_inicial_proyecto_params)

    respond_to do |format|
      if @presupuesto_inicial_proyecto.save
        format.html { redirect_to @presupuesto_inicial_proyecto, notice: "Presupuesto inicial proyecto was successfully created." }
        format.json { render :show, status: :created, location: @presupuesto_inicial_proyecto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @presupuesto_inicial_proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presupuesto_inicial_proyectos/1 or /presupuesto_inicial_proyectos/1.json
  def update
    respond_to do |format|
      if @presupuesto_inicial_proyecto.update(presupuesto_inicial_proyecto_params)
        format.html { redirect_to @presupuesto_inicial_proyecto, notice: "Presupuesto inicial proyecto was successfully updated." }
        format.json { render :show, status: :ok, location: @presupuesto_inicial_proyecto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @presupuesto_inicial_proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presupuesto_inicial_proyectos/1 or /presupuesto_inicial_proyectos/1.json
  def destroy
    @presupuesto_inicial_proyecto.destroy
    respond_to do |format|
      format.html { redirect_to presupuesto_inicial_proyectos_url, notice: "Presupuesto inicial proyecto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    presupuesto_inicial_ids = PresupuestoInicialProyecto.csv_import_proyecto(params[:file])
    redirect_to presupuesto_inicial_proyectos_path(ids: presupuesto_inicial_ids), notice: "Successfully Imported Data!!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presupuesto_inicial_proyecto
      @presupuesto_inicial_proyecto = PresupuestoInicialProyecto.find(params[:id])
    end

    def calc_totals(totales)
      # Se optienen las sumatoria de Totales 
      @total_valor_inicial = totales.map(&:valor_inicial).compact.reduce(&:+)
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_collection_select
      @rubros = Rubro.all
      @proyectos = Proyecto.all
    end

    # Only allow a list of trusted parameters through.
    def presupuesto_inicial_proyecto_params
      params.require(:presupuesto_inicial_proyecto).permit(:rubro_id, :proyecto_id, :descripcion, :valor_inicial)
    end

    def show_errors(exception)
      render json: exception, status: 400
    end
end
