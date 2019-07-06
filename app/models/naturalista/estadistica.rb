class Naturalista::Estadistica < ApplicationRecord

  establish_connection(:sqlite)

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

  def consultaNaturalista consulta
    uri = URI.parse(URI.escape("http://api.inaturalist.org/v1/" << consulta))
    req = Net::HTTP::Get.new(uri.to_s)

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      res = http.request(req)

      jres = JSON.parse(res.body)
    rescue => e
      jres = { estatus: 505, error: e.message }
    end

    jres
  end

end
