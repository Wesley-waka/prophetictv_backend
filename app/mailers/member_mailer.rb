class MemberMailer < ApplicationMailer
    def new_member_email
        @member =params[:member]
        @ADMIN_EMAIL = @member.email
        mail(to: @ADMIN_EMAIL, subject: "You have Successfully Signed up !")
    end
end
