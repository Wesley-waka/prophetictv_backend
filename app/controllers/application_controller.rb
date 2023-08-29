class ApplicationController < ActionController::API
    before_action :authorized
  
    def issue_token(user, user_type)   
      if(user_type == "admin")
        JWT.encode({ admin_id: user.id}, "My Sectet Key") 
      elsif(user_type == "member")  
        JWT.encode({ member_id: user.id}, "My Sectet Key")
      elsif(user_type == "super_admin")  
        JWT.encode({ super_admin_id: user.id}, "My Sectet Key") 
      end
    end
  
    def token
      request.headers["Authorization"]
    end
  
    def decoded_token
      begin
        JWT.decode(token, "My Sectet Key")
      rescue => exception
        [{ error: "Invalid Token" }]
      end
    end
  
    def current_user
      if(!decoded_token.first["admin_id"].nil?)
        return Admin.find_by(id: decoded_token.first["admin_id"])
      elsif(!decoded_token.first["member_id"].nil?)
    #     return User.find_by(id: decoded_token.first["user_id"])
    #   else
        return Member.find_by(id: decoded_token.first["member_id"])
      end
    end
  
    def logged_in?
      !!current_user
    end
  
    def authorized
      unless logged_in?
        render json: { message: "Please log in" }, status: :unauthorized
      end
    end
  end