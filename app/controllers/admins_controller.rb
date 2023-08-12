class AdminsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorized, only: %i[create show]

    def create
        @admin = Admin.new(admin_params)
        token = issue_token(@admin, "admin")
        if @admin.save
          admin_info = JSON.parse(
            @admin.to_json(only: [:id, :username, :email])
          )
          render json: { admin: admin_info, jwt: token }, status: :created
        else
          render json: { errors: @admin.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
    # def create
    #     @admin = Admin.new(admin_params)
    #     token = issue_token(@admin, "admin")
    #     @adm = @admin.save
    #     admin_info = JSON.parse(
    #         @adm.to_json only: [:id, :username, :email]
    #     )

    #     render json: {admin: admin_info, jwt: token }, status: :created
    # end

    def show
        admin = Admin.find(params[:id])
        token = issue_token(admin, "admin")

        admin_info = JSON.parse(
            admin.to_json only: [:id, :username, :email]
        )

        render json: {admin: admin_info, jwt: token }, status: :created
    end

    def update
        admin = Admin.find(params[:id])
        admin.update(admin_params)
        render json: admin, status: :ok
    end

    def destroy
        admin = Admin.find(params[:id])
        admin.destroy
        head :no_content
    end

    private
    def authorize
        Admin.find(session[:user_id])
    end

    def admin_params
        params.permit(:username, :email, :password, :church_id)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end   
end