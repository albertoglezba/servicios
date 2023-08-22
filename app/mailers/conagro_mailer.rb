class ConagroMailer < ApplicationMailer

    def inscripcion(conagro)
        @conagro = conagro
        mail(to: @conagro.correo, subject: "Inscripción Conferencia Agroecológica 2023")
    end

end
