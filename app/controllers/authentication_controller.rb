class AuthenticationController < ApplicationController
    # skip_before_action :authenticate_request
  
    def member_create
      @member = Member.find_by_email(params[:email])
      if @member&.authenticate(params[:password])
        # token = issue_token(@member.id,member)
        token = issue_token(@member)
        render json: { user: @member, token: token }, status: :ok
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    def member_destroy
      @member = Member.find_by_email(params[:email])
      if @member
        @member.destroy
        render json: { message: 'User logged out successfully' }, status: :ok
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end

    def admin_create
        @admin = Admin.find_by_email(params[:email])
        if @admin&.authenticate(params[:password])
          token = issue_token(@admin.id,admin)
        # token = issue_token(@admin)
          render json: { user:@admin, token: token }, status: :ok
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
    
      def admin_destroy
        @admin = Admin.find_by_email(params[:email])
        if @admin
            @admin.destroy
          render json: { message: 'User logged out successfully' }, status: :ok
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end


    def show
        if logged_in?
            render json: current_user
        else
            render json: { error: "Please log in" }
        end
    end

  
  end

#   def create
#     user = User.find_by(email: params[:email])

#     if user && user.authenticate(params[:password])
#       token = issue_token(user)
#       render json: {
#                user: UserSerializer.new(user),
#                jwt: token
#              },
#              status: :created
#     else
#       render json: {
#                message: "Invalid username or password"
#              },
#              status: :unauthorized
#     end
#   end

#   def show
#     if logged_in?
#       render json: current_user
#     else
#       render json: { error: "Please log in" }
#     end
#   end

#   private

#   def user_login_params
#     params.permit(:email, :password)
#   end