class MembersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorized, only: %i[create show]

    def index
        @member = Member.all
        render json: @member,status: :ok
    end

    def create
        # Default church_id to 1 if not provided
        # params[:church_id] ||= 1
        
        @member = Member.create!(member_params)
        token = issue_token(@member, "member")
      
        member_info = {
          id: @member.id,
          username: @member.username,
          email: @member.email
        }
        
      
        if @member.save
          MemberMailer.with(member: @member).new_member_email.deliver_later
          # flash[:success] = "Thank you for your order! We'll get in touch with you soon!"
          # redirect_to root_path
        else
          # flash.now[:error] = "Your order form had some errors. Please check the form and resubmit."
          render :new, status: :unprocessable_entity
        end
      
        render json: { member: member_info, jwt: token }, status: :created
      end
      

    def show
        @member = Member.find(params[:id])
        token = issue_token(@member, "member")

        member_info = JSON.parse(
            @member.to_json only: [:id, :username, :email]
        )

        render json: {admin: member_info, jwt: token }, status: :created
    end

    def update
        @member = Member.find(params[:id])
        @member.update(member_params)
        render json: @member, status: :ok
    end

    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        head :no_content
    end

    private
    def authorize
        User.find(session[:user_id])
    end

    def member_params
        params.permit(:username, :email,:password)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end   
end
