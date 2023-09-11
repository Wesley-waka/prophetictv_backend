class MinistryController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show]

    def index
        @ministry = Ministry.all
        render json:@ministry,include: [:admin, :members],status: :ok
    end
    def show
        @ministry = Ministry.find(params[:id])
        render json: @ministry,include: [:admin, :members],status: :ok
    end

    def create
        @ministry = Ministry.create!(ministry_params)
        render json: @ministry,status: :created
    end

    private
    def ministry_params
        params.permit(:ministryname,:ministrylocation)
    end
end
