module ApplicationHelper
  def at_servicios(url)
    request.original_url.include?("biodiversidad.gob.mx") ? "/servicios#{url}" : url
  end
end
