class Naturalista::Estadistica < ApplicationRecord
  establish_connection(:sqlite)

  def obtenerNumeroEspecies
    consulta = "observations/species_counts?project_id=#{id}"
    r = consultaNaturalista(consulta)
    if r[:status]
  end

  def obtenerNumeroObservaciones

  end

  def obtenerNumeroIdentificadores

  end

  def obtenerNumeroMiembros

  end

  def obtenerInfoProyectos

  end

  def consultaNaturalista consulta

    uri = URI.parse(URI.escape("http://api.inaturalist.org/v1/" << consulta))
    req = Net::HTTP::Get.new(uri.to_s)

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      #http.use_ssl = (uri.scheme == 'https')
      res = http.request(req)

      jres = JSON.parse(res.body)
    rescue => e
      jres = {status: false, error: e.message}
    end
    jres

  end

end
