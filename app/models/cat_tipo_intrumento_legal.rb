class CatTipoIntrumentoLegal < ApplicationRecord
  self.table_name = 'Cat_TipoIntrumentoLegal'

  has_many :Cat_GrupoInstrumentoLegal, class_name: 'CatGrupoInstrumentoLegal', foreign_key: 'IdCatGrupoInstrumentoLegal', primary_key: 'IdCatGrupoInstrumentoLegal'
  
end
