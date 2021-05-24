class PresupuestosController < ApplicationController
  include PresupuestosHelper
  rescue_from ActiveRecord::ActiveRecordError, with: :show_errors

  before_action :set_presupuesto, only: %i[ show edit update destroy ]
  before_action :report_by, only: %i[ index ]
  
  # GET /presupuestos or /presupuestos.json
  def index
    if params[:ids].blank?
      presupuestos_agg
      # @presupuestos = Presupuesto.where(id: params[:ids])
    else
      option = params[:reporte].to_sym
      presupuestos_agg
    end
    
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

  def new_import
  end

  def import
    presupuestos_ids = Presupuesto.csv_import(params[:file])
    redirect_to presupuestos_path(ids: presupuestos_ids), notice: "Successfully Imported Data!!"
  end

  def report_by
    reporte = params[:reporte].to_sym
    filter_option = params[:by]
    @reports = Presupuesto.all
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

    def show_errors(exception)
      render json: exception, status: 400
    end
end
