OPTS = Trollop::options do
  banner <<-EOS
Actualiza las estadisticas de los proyectos de naturalista: https://www.naturalista.mx/pages/estadisticas_proyectos

Usage:

  rails r tools/naturalista/actualiza_proyectos.rb -d            

where [options] are:
  EOS
  opt :debug, 'Print debug statements', :type => :boolean, :short => '-d'
end


start_time = Time.now

Naturalista::Estadistica.actualizaProyectos

Rails.logger.debug "Termino en #{Time.now - start_time} seg" if OPTS[:debug]
