module EventosHelper
  def at_servicios(url)
    "/servicios#{url}"
  end

  def dameFormato(formato)
    case formato
    when Calendario::Evento::FORMATO[0]
      "<i class='fa fa-street-view'></i> #{formato} <br>".html_safe
    when Calendario::Evento::FORMATO[1]
      "<i class='fa fa-wifi'></i> #{formato} <br>".html_safe
    when Calendario::Evento::FORMATO[2]
      "<i class='fa fa-street-view'></i> / <i class='fa fa-wifi'></i> #{formato} <br>".html_safe
    else
      formato
    end
  end

  def damePublicoMeta(publico)
    case publico
    when "Público General"
    "<i class='fa fa-users'></i> #{publico} <br>".html_safe
    when "Educación Superior"
    "<i class='fa fa-university'></i> #{publico} <br>".html_safe
    when /\AEducación/
      "<i class='fa fa-book'></i> #{publico} <br>".html_safe
    else
      publico
    end
  end

  def dameColorFormato(formato, celebracion)
    celebracion ? "#747b0e" : {"Presencial" => "#005378", "Virtual" => "#c2b59b", "Híbrido" => "#b55410"}[formato]
  end

end
