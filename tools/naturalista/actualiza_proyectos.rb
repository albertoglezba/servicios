require 'rubygems'
require 'trollop'

OPTS = Trollop::options do
  banner <<-EOS
Actualiza las estadisticas de los proyectos de naturalista: https://www.naturalista.mx/pages/estadisticas_proyectos

Usage:

  rails r tools/naturalista/actualiza_proyectos.rb -d pagina_inicio pagina_fin           

where [options] are:
  EOS
  opt :debug, 'Print debug statements', :type => :boolean, :short => '-d'
end


start_time = Time.now

if ARGV.count == 2
  paginas = (ARGV[0].to_i..ARGV[1].to_i).to_a
  #Rails.logger.debug paginas.inspect
  Naturalista::Estadistica.actualizaProyectos(paginas: paginas)
else
  Rails.logger.debug "Los argumentos necesitan ser dos: pagina inicial y pagina final" if OPTS[:debug]
end

Rails.logger.debug "Termino en #{Time.now - start_time} seg" if OPTS[:debug]
