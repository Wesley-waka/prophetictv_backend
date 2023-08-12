class MembersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorized, only: %i[create show]

    def create
        @member = Member.create(member_params)
        token = issue_token(@member, "member") # Make sure to use @member instead of member
    
        if @member.save
          member_info = JSON.parse(
            @member.to_json(only: [:id, :name, :email])
            # ,include: [:appointments, :practitioner_profiles, :department]
          )
    
          render json: { member: member_info, jwt: token }, status: :created
        else 
          render json: { errors: @member.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

    def show
        member = Member.find(params[:id])
        token = issue_token(practitioner, "member")

        member_info = JSON.parse(
            member.to_json only: [:id, :username, :email]
            # include: [:appointments, :practitioner_profiles, :department]
        )

        render json: {practitioner: member_info, jwt: token }, status: :created
    end

    def index
        render json: Member.all, status: :ok
    end

    def destroy
        member = Member.find(params[:id])
        member.destroy
        head :no_content
    end

    private
    def member_params
        params.permit(:name, :password, :email, :church_id)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end  
end
