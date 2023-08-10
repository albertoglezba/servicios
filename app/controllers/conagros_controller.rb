class ConagrosController < ApplicationController
  before_action :set_conagro, only: [:show, :edit, :update, :destroy]

  # GET /conagros
  # GET /conagros.json
  def index
    @conagros = Conagro.all
  end

  # GET /conagros/1
  # GET /conagros/1.json
  def show
  end

  # GET /conagros/new
  def new
    @conagro = Conagro.new
  end

  # GET /conagros/1/edit
  def edit
  end

  # POST /conagros
  # POST /conagros.json
  def create
    @conagro = Conagro.new(conagro_params)

    respond_to do |format|
      if @conagro.save
        format.html { redirect_to @conagro, notice: 'Conagro was successfully created.' }
        format.json { render :show, status: :created, location: @conagro }
      else
        format.html { render :new }
        format.json { render json: @conagro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conagros/1
  # PATCH/PUT /conagros/1.json
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

  # DELETE /conagros/1
  # DELETE /conagros/1.json
  def destroy
    @conagro.destroy
    respond_to do |format|
      format.html { redirect_to conagros_url, notice: 'Conagro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conagro
      @conagro = Conagro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conagro_params
      params.require(:conagro).permit(:nombre, :apellidos, :correo, :pais, :institucion, :cargo, :eje)
    end
end
