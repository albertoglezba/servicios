class Naturalista::Estadistica < ApplicationRecord

  establish_connection(:sqlite)

  POR_PAGINA = 20.freeze
  MIN_OBS = 50  # El minimo de observaciones para que el proyecto lo guardemos

  def self.actualizaProyectos
    consulta = 'projects?place_id=6793&per_page=1&page=1'
    jresp = Naturalista::Estadistica.new.consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    paginas = jresp['total_results']%POR_PAGINA > 0 ? (jresp['total_results']/POR_PAGINA) + 1 : jresp['total_results']/POR_PAGINA
    paginas.times do |i|
      consulta = "projects?place_id=6793&per_page=#{POR_PAGINA}&page=#{i+1}"
      jresp = Naturalista::Estadistica.new.consultaNaturalista(consulta)
      return unless jresp['total_results'].present?

      jresp['results'].each do |p|
        Rails.logger.debug "[DEBUG] - Proyecto ID: #{p['id']}"

        begin
          proyecto = Naturalista::Estadistica.find(p['id'])
          Rails.logger.debug "[DEBUG] - Proyecto existente"
        rescue
          proyecto = Naturalista::Estadistica.new
          proyecto.id = p['id'].to_i
          Rails.logger.debug "[DEBUG] - Proyecto nuevo"
        end

        proyecto.actualizaProyecto
      end

      return
    end

  end

  def actualizaProyecto
    obtenerNumeroObservaciones
    return if numero_observaciones < MIN_OBS

    obtenerInfoProyectos
    obtenerNumeroEspecies
    obtenerNumeroObservadores
    obtenerNumeroIdentificadores
    obtenerNumeroMiembros
    obtenerUbicacion if lugar_id.present?

    if changed?
      Rails.logger.debug "[DEBUG] - Hubo cambios"
      save
    else
      Rails.logger.debug "[DEBUG] - Sin cambios"
    end

    sleep(5)  # Para evitar que nos bannen otra vez
  end

  def obtenerInfoProyectos
    consulta = "projects/#{id}"
    jresp = consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    proyecto = jresp['results'][0]
    self.id = proyecto['id']
    self.titulo = proyecto['title']
    self.icono = proyecto['icon']
    self.descripcion = proyecto['description']
    self.lugar_id = proyecto['place_id']
    self.created_at = proyecto['created_at']
    self.updated_at = proyecto['updated_at']
  end

  def obtenerNumeroEspecies
    consulta = "observations/species_counts?project_id=#{id}"
    jresp = consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    self.numero_especies = jresp['total_results']
  end

  def obtenerNumeroObservaciones
    consulta = "observations?project_id=#{id}"
    jresp = consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    self.numero_observaciones = jresp['total_results']
  end

  def obtenerNumeroObservadores
    consulta = "observations/observers?project_id=#{id}"
    jresp = consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    self.numero_observadores = jresp['total_results']
  end

  def obtenerNumeroIdentificadores
    consulta = "observations/identifiers?project_id=#{id}"
    jresp = consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    self.numero_identificadores = jresp['total_results']
  end

  def obtenerNumeroMiembros
    consulta = "projects/#{id}/members"
    jresp = consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    self.numero_miembros = jresp['total_results']
  end

  def obtenerUbicacion
    consulta = "places/#{lugar_id}"
    jresp = consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    self.ubicacion = jresp['results'][0]['display_name']
  end

  def consultaNaturalista(consulta)
    url = "http://api.inaturalist.org/v1/" << consulta

    begin
      rest_client = RestClient::Request.execute(method: :get, url: url, timeout: 20)
      jres = JSON.parse(rest_client)
    rescue => e
      jres = { estatus: 505, error: e.message }
    end

    jres
  end

end
