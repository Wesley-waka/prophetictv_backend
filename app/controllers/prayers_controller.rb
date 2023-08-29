class PrayersController < ApplicationController
    skip_before_action :authorized, only: %i[index create]

    def index
        @prayers = Prayer.all
        render json: @prayers,status: :ok
    end
    def create
        @prayer = Prayer.create!(prayer_params)
        render json: @prayer,status: :created
    end

    def destroy
        @prayer = Prayer.find(params[:id])
        @prayer.destroy
        head :no_content
    end

    def update
        @prayer = Prayer.find(params[:id])
        @prayer.update(prayer_params)
        render json: @prayer, status: :ok
    end

    private

    def set_prayer
        @prayer = Prayer.find(params[:id])
    end

    def prayer_params
        params.permit(:username,:email,:title)
    end

end
