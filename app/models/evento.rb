class Evento < ApplicationRecord

    ACTIVIDAD = ["Conferencia / Plática", "Concierto", "Conversatorio", "Curso / Taller", "Difusión en medios de comunicación", "Entrevista", "Exposición fotográfica", "Foro", "Limpieza", "Observación de aves", "Presentación de libro", "Puertas abiertas", "Proyección", "Recorridos", "Reforestación", "Restauración", "Reunión", "Visita guiada", "Otra"].freeze
    
    FORMATO = ["Híbrido", "Presencial", "Virtual"].freeze

    PUBLICO_META = ["Público General", "Educación Básica", "Educación Media Superior", "Educación Superior", "Educación Continua", "Educación Especial", "Escuela Normal"].freeze

    ESTADO = ["A nivel nacional", "Aguascalientes", "Baja California", "Baja California Sur", "Campeche", "Chiapas", "Chihuahua", "Coahuila", "Colima", "Ciudad de México", "Durango", "Estado de México", "Guanajuato", "Guerrero", "Hidalgo", "Jalisco", "Michoacán", "Morelos", "Nayarit", "Nuevo León", "Oaxaca", "Puebla", "Querétaro", "Quintana Roo", "San Luis Potosí", "Sinaloa", "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz", "Yucatán", "Zacatecas"].freeze

    validates :titulo, :actividad, :fecha_ini, :fecha_fin, :descripcion, :estado, :publico_meta, :formato, :informes, presence: true
end
