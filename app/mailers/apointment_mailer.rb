class ApointmentMailer < ApplicationMailer
    def new_appointment_email
        @member =params[:appointment]
        @ADMIN_EMAIL = 'prophetictvevent@gmail.com'
        mail(to: @ADMIN_EMAIL, subject: "You have Successfully Signed up !")
    end
end
