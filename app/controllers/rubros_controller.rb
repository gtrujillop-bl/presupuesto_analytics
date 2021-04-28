class RubrosController < ApplicationController
  before_action :set_rubro, only: %i[ show edit update destroy ]

  # GET /rubros or /rubros.json
  def index
    @rubros = Rubro.all
  end

  # GET /rubros/1 or /rubros/1.json
  def show
  end

  # GET /rubros/new
  def new
    @rubro = Rubro.new
  end

  # GET /rubros/1/edit
  def edit
  end

  # POST /rubros or /rubros.json
  def create
    @rubro = Rubro.new(rubro_params)

    respond_to do |format|
      if @rubro.save
        format.html { redirect_to @rubro, notice: "Rubro was successfully created." }
        format.json { render :show, status: :created, location: @rubro }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rubro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rubros/1 or /rubros/1.json
  def update
    respond_to do |format|
      if @rubro.update(rubro_params)
        format.html { redirect_to @rubro, notice: "Rubro was successfully updated." }
        format.json { render :show, status: :ok, location: @rubro }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rubro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rubros/1 or /rubros/1.json
  def destroy
    @rubro.destroy
    respond_to do |format|
      format.html { redirect_to rubros_url, notice: "Rubro was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rubro
      @rubro = Rubro.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rubro_params
      params.require(:rubro).permit(:nombre, :descripcion)
    end
end
