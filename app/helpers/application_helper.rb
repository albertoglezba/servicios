module ApplicationHelper
  def at_servicios(url)
    Rails.env.production? ? "/servicios#{url}" : url
  end
end
