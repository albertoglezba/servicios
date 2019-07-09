class Naturalista::EstadisticasController < ApplicationController
  before_action :set_naturalista_estadistica, only: [:show, :edit, :update, :destroy]

  # GET /naturalista/estadisticas
  # GET /naturalista/estadisticas.json
  def index
    @naturalista_estadisticas = Naturalista::Estadistica.all
  end

  # GET /naturalista/estadisticas/1
  # GET /naturalista/estadisticas/1.json
  def show
  end

  # GET /naturalista/estadisticas/new
  def new
    @naturalista_estadistica = Naturalista::Estadistica.new
  end

  # GET /naturalista/estadisticas/1/edit
  def edit
  end

  # POST /naturalista/estadisticas
  # POST /naturalista/estadisticas.json
  def create
    @naturalista_estadistica = Naturalista::Estadistica.new(naturalista_estadistica_params)

    respond_to do |format|
      if @naturalista_estadistica.save
        format.html { redirect_to @naturalista_estadistica, notice: 'Estadistica was successfully created.' }
        format.json { render :show, status: :created, location: @naturalista_estadistica }
      else
        format.html { render :new }
        format.json { render json: @naturalista_estadistica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /naturalista/estadisticas/1
  # PATCH/PUT /naturalista/estadisticas/1.json
  def update
    respond_to do |format|
      if @naturalista_estadistica.update(naturalista_estadistica_params)
        format.html { redirect_to @naturalista_estadistica, notice: 'Estadistica was successfully updated.' }
        format.json { render :show, status: :ok, location: @naturalista_estadistica }
      else
        format.html { render :edit }
        format.json { render json: @naturalista_estadistica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /naturalista/estadisticas/1
  # DELETE /naturalista/estadisticas/1.json
  def destroy
    @naturalista_estadistica.destroy
    respond_to do |format|
      format.html { redirect_to naturalista_estadisticas_url, notice: 'Estadistica was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_naturalista_estadistica
      @naturalista_estadistica = Naturalista::Estadistica.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def naturalista_estadistica_params
      params.require(:naturalista_estadistica).permit(:titulo, :icono, :descripcion, :lugar_id, :numero_especies, :numero_observaciones, :numero_observadores, :numero_identificadores, :numero_miembros, :estado, :tipo_lugar, :ubicacion)
    end
end
