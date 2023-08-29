class ChurchesController < ApplicationController
    
    def index
        @church = Church.all
        render json: @church, include: [:admin, :members], status: :ok
    end

    def show
        @church=Church.find_by(params[:id])
        render json: @church, include: [:admin, :members], status: :ok
    end

end
