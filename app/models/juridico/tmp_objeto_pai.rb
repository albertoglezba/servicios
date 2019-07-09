class Juridico::TmpObjetoPai < Instrumentos
  self.table_name = '#tmpObjetoPAI'

  has_many :Cat_instituciones, class_name: 'CatInstitucion', foreign_key: 'NombreInstitucion', primary_key: 'DatoPersonaAreaInstutucion'
  
end
