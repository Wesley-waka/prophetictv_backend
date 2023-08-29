class AdminMailer < ApplicationMailer
    def new_admin_email
        @member =params[:admin]
        @ADMIN_EMAIL = @member.email
        mail(to: @ADMIN_EMAIL, subject: "You have Successfully Signed up !")
    end
end
