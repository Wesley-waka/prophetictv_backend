class AdminsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorized, only: %i[create show]

    def create
        @admin = Admin.create!(admin_params)
        token = issue_token(@admin, "admin")

        admin_info = JSON.parse(
            @admin.to_json only: [:id, :username, :email]
        )

        if @admin.save
           AdminMailer.with(admin: @admin).new_admin_email.deliver_later
            # flash[:success] = "Thank you for your order! We'll get in touch with you soon!"
            # redirect_to root_path
          else
            # flash.now[:error] = "Your order form had some errors. Please check the form and resubmit."
            render :new, status: :unprocessable_entity
          end
        
        render json: {admin: admin_info, jwt: token }, status: :created
    end

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
        User.find(session[:user_id])
    end

    def admin_params
        params.permit(:username, :email,:ministry_id,:password)
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found(not_found)
        render json: not_found, status: 404
    end   
end