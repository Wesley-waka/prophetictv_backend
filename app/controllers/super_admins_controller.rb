class SuperAdminsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorized, only: %i[create show]

    def create
        @admin = SuperAdmin.create!(admin_params)
        token = issue_token(@admin, "master")

        admin_info = JSON.parse(
            @admin.to_json only: [:id, :username, :email]
        )

        
        
        render json: {admin: admin_info, jwt: token }, status: :created
    end

    def show
        admin = SuperAdmin.find(params[:id])
        token = issue_token(admin, "admin")

        admin_info = JSON.parse(
            admin.to_json only: [:id, :username, :email]
        )

        render json: {admin: admin_info, jwt: token }, status: :created
    end

    def update
        admin = SuperAdmin.find(params[:id])
        admin.update(admin_params)
        render json: admin, status: :ok
    end

    def destroy
        admin = SuperAdmin.find(params[:id])
        admin.destroy
        head :no_content
    end

    private
    def authorize
        SuperAdmin.find(session[:user_id])
    end

    def admin_params
        params.permit(:username, :email,:password)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end 
end
