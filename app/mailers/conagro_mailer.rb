class ConagroMailer < ApplicationMailer

    def inscripcion(conagro)
        @conagro = conagro
        mail(to: @conagro.correo, bcc: "conferenciaagroecologia2023@gmail.com", subject: "Inscripción Conferencia Agroecológica 2023")
    end

end
