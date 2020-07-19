class Naturalista::Estadistica < ApplicationRecord

  POR_PAGINA = 30.freeze
  MIN_OBS = 50  # El minimo de observaciones para que el proyecto lo guardemos
  ORDEN = [['Número de observaciones', 'numero_observaciones'],['Número de especies', 'numero_especies'],['Número de observadores', 'numero_observadores'],['Número de identificadores', 'numero_identificadores'],['Número de miembros', 'numero_miembros']]
  TIPOS_PROYECTOS = {'Tipo de lugar' => ['ANP', 'Parque urbano', 'Zonas arqueológicas'], 'Región' => ['Estatal','Municipal','Nacional'], 'Grupo taxonómico' => %w(Anfibios Aves Bacterias Hongos Invertebrados Mamíferos Peces Plantas Protoctistas Reptiles)}
  ESTADOS = { 11163 => 'Aguascalientes', 59014 => 'Ciudad de México', 11166 => 'Durango', 7411 => 'Jalisco', 9741 => 'Guerrero', 13117 => 'Veracruz', 7255 => 'Colima', 7450 => 'Tabasco', 8501 => 'Baja California', 7403 => 'Baja California Sur', 8295 => 'Oaxaca', 7447 => 'Zacatecas',7434 => 'Campeche', 97003 => 'Chiapas', 11165 => 'Chihuahua', 67520 => 'Michoacán', 8498 => 'Nayarit', 11167 => 'Hidalgo', 8150 => 'Guanajuato',58810 => 'San Luis Potosí', 6794 => 'Sonora', 7187 => 'Sinaloa', 67478 => 'Yucatán', 11172 => 'Tlaxcala', 6935 => 'Coahuila', 7430 => 'Morelos',11168 => 'Estado de México', 11169 => 'Nuevo León', 7404 => 'Puebla', 67136 => 'Querétaro', 7426 => 'Quintana Roo', 7443 => 'Tamaulipas'}

  scope :where_like, -> (campo, valor) { where("#{campo} LIKE '%#{valor}%'") }
  attr_accessor :orden

  # Hace el query con los propios campos :O
  def busqueda
    naturalista_estadisticas = Naturalista::Estadistica.where(publico: true)
    naturalista_estadisticas = naturalista_estadisticas.where_like('titulo', titulo) if titulo.present?
    naturalista_estadisticas = naturalista_estadisticas.where_like('ubicacion', ubicacion) if ubicacion.present?
    naturalista_estadisticas = naturalista_estadisticas.where_like('tipo_proyecto', tipo_proyecto) if tipo_proyecto.present?
    naturalista_estadisticas = naturalista_estadisticas.where(estado: estado) if estado.present?
    naturalista_estadisticas.order("#{orden} DESC") if orden.present?
  end

  def self.actualizaProyectosFallidos
    Naturalista::Estadistica.where("titulo IS NULL").each do |e|
      Rails.logger.debug "[DEBUG] - Proyecto ID: #{e.id}"
      e.actualizaProyecto
    end
  end

  def self.actualizaProyectos
    consulta = 'projects?place_id=6793&per_page=1&page=1'
    jresp = Naturalista::Estadistica.new.consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    paginas = jresp['total_results']%POR_PAGINA > 0 ? (jresp['total_results']/POR_PAGINA) + 1 : jresp['total_results']/POR_PAGINA
    paginas.times do |i|
      consulta = "projects?place_id=6793&per_page=#{POR_PAGINA}&page=#{i+1}&order_by=created"
      jresp = Naturalista::Estadistica.new.consultaNaturalista(consulta)
      return unless jresp['total_results'].present?

      jresp['results'].each do |p|
        #next unless p['id'] == 687
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

      end  # End todos los proyectos por pagina
    end  # End paginado

  end

  def actualizaProyecto
    obtenerNumeroObservaciones
    #return if numero_observaciones < MIN_OBS

    obtenerInfoProyectos
    obtenerNumeroEspecies
    obtenerNumeroObservadores
    sleep(3)  # Para evitar que nos bannen otra vez
    obtenerNumeroIdentificadores
    obtenerNumeroMiembros
    obtenerUbicacion if lugar_id.present?

    if changed?
      Rails.logger.debug "[DEBUG] - Hubo cambios"
      save
    else
      Rails.logger.debug "[DEBUG] - Sin cambios"
    end

    sleep(3)  # Para evitar que nos bannen otra vez
  end

  def obtenerInfoProyectos
    consulta = "projects/#{id}"
    jresp = consultaNaturalista(consulta)
    return unless (jresp['total_results'].present? && jresp['total_results'] > 0)

    proyecto = jresp['results'][0]
    self.id = proyecto['id']
    self.titulo = proyecto['title']
    self.icono = proyecto['icon']
    self.descripcion = proyecto['description']
    self.lugar_id = proyecto['place_id']
    self.clase_proyecto = proyecto['project_type']
    self.created_at = proyecto['created_at']
    self.updated_at = proyecto['updated_at']
  end

  def obtenerNumeroEspecies
    consulta = "observations/species_counts?project_id=#{id}&per_page=1"
    jresp = consultaNaturalista(consulta)
    return unless (jresp['total_results'].present? && jresp['total_results'] > 0)

    self.numero_especies = jresp['total_results']
  end

  def obtenerNumeroObservaciones
    consulta = "observations?project_id=#{id}&per_page=1"
    jresp = consultaNaturalista(consulta)
    return unless (jresp['total_results'].present? && jresp['total_results'] > 0)

    self.numero_observaciones = jresp['total_results']
  end

  def obtenerNumeroObservadores
    consulta = "observations/observers?project_id=#{id}&per_page=1"
    jresp = consultaNaturalista(consulta)
    return unless (jresp['total_results'].present? && jresp['total_results'] > 0)

    self.numero_observadores = jresp['total_results']
  end

  def obtenerNumeroIdentificadores
    consulta = "observations/identifiers?project_id=#{id}&per_page=1"
    jresp = consultaNaturalista(consulta)
    return unless (jresp['total_results'].present? && jresp['total_results'] > 0)

    self.numero_identificadores = jresp['total_results']
  end

  def obtenerNumeroMiembros
    consulta = "projects/#{id}/members?per_page=1"
    jresp = consultaNaturalista(consulta)
    return unless (jresp['total_results'].present? && jresp['total_results'] > 0)

    self.numero_miembros = jresp['total_results']
  end

  def obtenerUbicacion
    consulta = "places/#{lugar_id}"
    jresp = consultaNaturalista(consulta)
    return unless (jresp['total_results'].present? && jresp['total_results'] > 0)

    asignaEstado(jresp['results'][0]['ancestor_place_ids'])
    self.ubicacion = jresp['results'][0]['display_name']
  end

  def asignaEstado(ancestry)
    return unless ancestry.present?

    ancestry.each do |a|
      if ESTADOS.key?(a)
        self.estado = ESTADOS[a]
        return
      end
    end
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
