class Naturalista::Estadistica < ApplicationRecord

  establish_connection(:sqlite)

  POR_PAGINA = 30.freeze

  def self.actualizaProyectos
    consulta = 'projects?place_id=6793'
    jresp = Naturalista::Estadistica.new.consultaNaturalista(consulta)
    return unless jresp['total_results'].present?

    paginas = jresp['total_results']%POR_PAGINA > 0 ? (jresp['total_results']/POR_PAGINA) + 1 : jresp['total_results']/POR_PAGINA
    paginas.times do |i|
      consulta = "projects?place_id=6793&per_page=#{POR_PAGINA}&page=#{i+1}"
      jresp = Naturalista::Estadistica.new.consultaNaturalista(consulta)
      return unless jresp['total_results'].present?

      jresp['results'].each do |proyecto|
        begin
          proyecto = Naturalista::Estadistica.find(proyecto['id'])
        rescue
          proyecto = Naturalista::Estadistica.new
          proyecto.id = proyecto['id'].to_i
        end

        proyecto.actualizaProyecto
      end

      return
    end

  end

  def actualizaProyecto
    obtenerInfoProyectos
    obtenerNumeroEspecies
    obtenerNumeroObservaciones
    obtenerNumeroObservadores
    obtenerNumeroIdentificadores
    obtenerNumeroMiembros

    save if changed?
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

  def consultaNaturalista(consulta)
    url = "http://api.inaturalist.org/v1/" << consulta
    #req = Net::HTTP::Get.new(uri.to_s)

    begin
      rest_client = RestClient::Request.execute(method: :get, url: url, timeout: 20)
      jres = JSON.parse(rest_client)
    rescue => e
      jres = { estatus: 505, error: e.message }
    end

    jres
  end

end
