class ChurchesController < ApplicationController
    
    def index
        @church = Church.all
        render json: @church, include: [:admin, :members], status: :ok
    end

    def create
        @church = Church.create!(church_params)
        render json: @church,status: :created
    end

    def show
        @church=Church.find_by(params[:id])
        render json: @church, include: [:admin, :members], status: :ok
    end

    private

    def church_params
        params.permit(:name,:postalAddress)
    end

end
