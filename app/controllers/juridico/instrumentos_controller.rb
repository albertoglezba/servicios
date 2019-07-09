class Juridico::InstrumentosController < ApplicationController
  before_action :set_juridico_instrumento, only: [:show, :edit, :update, :destroy]
  layout false
  
  # GET /instrumentos
  # GET /instrumentos.json
  def index
    @juridico_instrumentos = Juridico::DatInstrumentoLegal.consulta
  end

  # GET /instrumentos/1
  # GET /instrumentos/1.json
  def show
  end

  # GET /instrumentos/new
  def new
    @juridico_instrumento = Juridico::DatInstrumentoLegal.new
  end

  # GET /instrumentos/1/edit
  def edit
  end

  # POST /instrumentos
  # POST /instrumentos.json
  def create
    @juridico_instrumento = Juridico::DatInstrumentoLegal.new(juridico_instrumento_params)

    respond_to do |format|
      if @juridico_instrumento.save
        format.html { redirect_to @juridico_instrumento, notice: 'Instrumento was successfully created.' }
        format.json { render :show, status: :created, location: @juridico_instrumento }
      else
        format.html { render :new }
        format.json { render json: @juridico_instrumento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instrumentos/1
  # PATCH/PUT /instrumentos/1.json
  def update
    respond_to do |format|
      if @juridico_instrumento.update(juridico_instrumento_params)
        format.html { redirect_to @juridico_instrumento, notice: 'Instrumento was successfully updated.' }
        format.json { render :show, status: :ok, location: @juridico_instrumento }
      else
        format.html { render :edit }
        format.json { render json: @juridico_instrumento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instrumentos/1
  # DELETE /instrumentos/1.json
  def destroy
    @juridico_instrumento.destroy
    respond_to do |format|
      format.html { redirect_to juridico_instrumentos_url, notice: 'Instrumento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_juridico_instrumento
      @instrumento = Juridico::DatInstrumentoLegal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def juridico_instrumento_params
      params.require(:juridico_instrumento).permit(:Identificador1, :Grupo, :TipoInstrumentoLegal, :Objeto, :MontoTotal, :VersionPublica, :Nombre, :Apellido, :DatoPersonaAreaInstutucion)
    end
end
