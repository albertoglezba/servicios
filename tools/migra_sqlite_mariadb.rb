OPTS = Trollop::options do
  banner <<-EOS
migra los registros de sqlite a mariadb, nota: hay q cambiar database.yml para q acepte los simbolos

Usage:

  rails r tools/migra_sqlite_mariadb.rb          

  EOS
end


ActiveRecord::Base.establish_connection(:prod_sqlite)

stats = Naturalista::Estadistica.all.map(&:attributes)
eventos = Calendario::Evento.all.map(&:attributes)

ActiveRecord::Base.establish_connection(:development)

stats.each do |s|
  Naturalista::Estadistica.create s
end

eventos.each do |e|
  Calendario::Evento.create e
end