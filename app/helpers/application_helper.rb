module ApplicationHelper
  def at_servicios(url)
    request.original_url.include?("biodiversidad") ? "/servicios#{url}" : url
  end
end
