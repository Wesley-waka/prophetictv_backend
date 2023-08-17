class MembersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorized, only: %i[create show]

    def create
        @member = Member.create!(member_params)
        token = issue_token(@member, "member")

        role = params[:church_id] || 1
        member_info = JSON.parse(
            @member.to_json only: [:id, :username, :email]
        )

        render json: {member: member_info, jwt: token }, status: :created
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
        params.permit(:username, :email,:church_id,:password,:password_confirmation)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end   
end
