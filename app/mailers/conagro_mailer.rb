class ConagroMailer < ApplicationMailer

    SECRETS = YAML.load(File.read(File.expand_path('../../../config/secrets.yml', __FILE__)))

    def inscripcion(conagro)
        @conagro = conagro
        mail(to: @conagro.correo, bcc: SECRETS["mail"]["bcc"], subject: "Inscripción Conferencia Agroecológica 2023")
    end

end
