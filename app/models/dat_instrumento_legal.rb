class DatInstrumentoLegal < ApplicationRecord

  self.table_name = 'Dat_InstrumentoLegal'
  
  #attr_accessor :x_grupo, :TipoInstrumentoLegal, :Nombre, :Apellido, :DatoPersonaAreaInstutucion

  has_many :Cat_AreasCONABIO, class_name: 'CatAreasConabio', foreign_key: 'IdCatAreasCONABIO', primary_key: 'IdAreaCONABIOResponsable'
  has_many :tmpObjetoPAI, class_name: 'TmpObjetoPai', foreign_key: 'Id_Instrumento', primary_key: 'IdInstrumentoLegal'
  has_many :Cat_TipoIntrumentoLegal, class_name: 'CatTipoIntrumentoLegal', foreign_key: 'IdCatTipoInstrumentoLegal', primary_key: 'IdTipoInstrumentoLegal'

  has_many :Cat_GrupoInstrumentoLegal, through: :Cat_TipoIntrumentoLegal, source: :Cat_GrupoInstrumentoLegal
  has_many :Cat_instituciones, through: :tmpObjetoPAI, source: :Cat_instituciones
  
  scope :consulta, -> {select('Dat_InstrumentoLegal.Identificador1
, Cat_GrupoInstrumentoLegal.Grupo
, Cat_TipoIntrumentoLegal.TipoInstrumentoLegal
, Dat_InstrumentoLegal.Objeto
, Dat_InstrumentoLegal.MontoTotal
, Dat_InstrumentoLegal.VersionPublica
, `#tmpObjetoPAI`.Nombre
, `#tmpObjetoPAI`.Apellido
, `#tmpObjetoPAI`.DatoPersonaAreaInstutucion').from('Dat_InstrumentoLegal').joins(:Cat_AreasCONABIO, :Cat_GrupoInstrumentoLegal, :Cat_instituciones).where('Cat_Instituciones.IdInstitucionAsc Not In (1622,2927)').where('Year(`FechaFirma`) In (2018,2019)') }

    
end
