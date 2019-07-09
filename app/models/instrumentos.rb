class Instrumentos < ApplicationRecord

  self.abstract_class = true
  establish_connection(:instrumentos)
end