class AdminMailer < ApplicationMailer
    def new_admin_email
        @admin =params[:admin]
        @ADMIN_EMAIL = @admin.email
        mail(to: @ADMIN_EMAIL, subject: "You have Successfully Signed up !")
    end
end
