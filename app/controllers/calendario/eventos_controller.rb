class Calendario::EventosController < ApplicationController

  before_action :cors_set_access_control_headers, except: [:index]
  before_action :authenticate_eventos, except: [:index, :login]
  before_action :set_evento, only: [:show, :edit, :update, :destroy]
  before_action :tiene_permisos?, only: [:show, :edit, :update, :destroy]
  layout false, except: [:index]

  # GET /eventos
  # GET /eventos.json
  def index
    @eventos = Calendario::Evento.all.order(fecha_ini: :desc)
  end

  def mis_eventos
    @eventos = Calendario::Evento.mis_eventos(@usuario)
  end

  def login
  end

  # GET /eventos/1
  # GET /eventos/1.json
  def show
  end

  # GET /eventos/new
  def new
    @evento = Calendario::Evento.new
  end

  # GET /eventos/1/edit
  def edit
  end

  # POST /eventos
  # POST /eventos.json
  def create
    @evento = Calendario::Evento.new(evento_params)
    @evento.usuario = @usuario  # Asigna el usuario

    respond_to do |format|
      if @evento.save
        format.html { redirect_to @evento, notice: 'Evento was successfully created.' }
        format.json { render :show, status: :created, location: @evento }
      else
        format.html { render :new }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eventos/1
  # PATCH/PUT /eventos/1.json
  def update
    respond_to do |format|
      if @evento.update(evento_params)
        format.html { redirect_to @evento, notice: 'Evento was successfully updated.' }
        format.json { render :show, status: :ok, location: @evento }
      else
        format.html { render :edit }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventos/1
  # DELETE /eventos/1.json
  def destroy
    @evento.destroy
    @eventos = Calendario::Evento.mis_eventos(@usuario)
    respond_to do |format|
      #format.html { render "calendario/eventos/mis_eventos", notice: 'Evento was successfully destroyed.' }
      format.html { render plain: "borrado", content_type: 'text/plain' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evento
      @evento = Calendario::Evento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evento_params
      params.require(:calendario_evento).permit(:titulo, :actividad, :otra_actividad, :descripcion, :fecha_ini, :fecha_fin, :publico_meta, :formato, :estado, :informes, :celebracion)
    end

    def tiene_permisos?
      return true if @evento.usuario == @usuario
      raise ActionController::RoutingError, 'Not Found'
    end

    def authenticate_eventos
      authenticate(:eventos)
    end

end
