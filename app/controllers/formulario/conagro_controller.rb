class Formulario::ConagroController < ApplicationController
  before_action :set_conagro, only: [:show, :edit, :update, :destroy]
  layout "formulario"

  # GET /conagro
  # GET /conagro.json
  def index
    @conagro = Formulario::Conagro.all
  end

  # GET /conagro/1
  # GET /conagro/1.json
  def show
  end

  # GET /conagro/new
  def new
    @conagro = Formulario::Conagro.new
  end

  # GET /conagro/1/edit
  def edit
  end

  # POST /conagro
  # POST /conagro.json
  def create
    params["formulario_conagro"]["eje"] = params["formulario_conagro"]["eje"].delete_if {|eje| eje == "0"}
    params["formulario_conagro"]["eje"] = nil  if params["formulario_conagro"]["eje"].empty?
    
    @conagro = Formulario::Conagro.new(conagro_params)

    respond_to do |format|
      if @conagro.save
        ConagroMailer.inscripcion(@conagro).deliver

        format.html { redirect_to new_formulario_conagro_url, notice: 'Tu inscripción quedo registrada correctamente. Mandaremos un correo con la confirmación de tu inscripción, asegurate de revisar también la bandeja de spam.' }
        format.json { render :show, status: :created, location: @conagro }
      else
        format.html { render :new }
        format.json { render json: @conagro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conagro/1
  # PATCH/PUT /conagro/1.json
  def update
    respond_to do |format|
      if @conagro.update(conagro_params)
        format.html { redirect_to @conagro, notice: 'Conagro was successfully updated.' }
        format.json { render :show, status: :ok, location: @conagro }
      else
        format.html { render :edit }
        format.json { render json: @conagro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conagro/1
  # DELETE /conagro/1.json
  def destroy
    @conagro.destroy
    respond_to do |format|
      format.html { redirect_to conagro_url, notice: 'Conagro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conagro
      @conagro = Formulario::Conagro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conagro_params
      params.require(:formulario_conagro).permit(:nombre, :apellidos, :correo, :pais, :tipo_institucion, :institucion, :cargo, eje: [])
    end
end
