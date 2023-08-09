module EventosHelper
  def at_servicios(url)
    "/servicios#{url}"
  end

  def dameFormato(formato)
    case formato
    when Calendario::Evento::FORMATO[0]
      "<i class='fa fa-street-view'></i> #{formato}".html_safe
    when Calendario::Evento::FORMATO[1]
      "<i class='fa fa-wifi'></i> #{formato}".html_safe
    when Calendario::Evento::FORMATO[2]
      "<i class='fa fa-street-view'>/</i><i class='fa fa-wifi'></i> #{formato}".html_safe
    else
      formato
    end
  end

  def damePublicoMeta(publico)
    case publico
    when "Público General"
    "<i class='fa fa-users'></i> #{publico}".html_safe
    when "Educación Superior"
    "<i class='fa fa-university'></i> #{publico}".html_safe
    when /\AEducación/
      "<i class='fa fa-book'></i> #{publico}".html_safe
    else
      publico
    end
  end

end
