class MemberSessionsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from NoMethodError, with: :couldnt_log_you_in
    skip_before_action :authorized, only: %i[create]

    def create
        @member = Member.find_by!(username: params[:username])
        @member = @member.authenticate(params[:password])
        token = issue_token(@member, "member")

        member_info = JSON.parse(
            @member.to_json only: [:id, :username, :email]
        )

        render json: {admin: member_info, jwt: token }, status: :created
    end

    def destroy
        head :no_content
    end

    private
    def couldnt_log_you_in
        render json: {error: "Couldn't log you in. Check to confirm if your passowrd is correct"}, status: :unprocessable_entity
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end 
end
