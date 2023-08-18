class AppointmentsController < ApplicationController
    before_action :set_appointment, only: %i[create show]
    skip_before_action :authorized, only: %i[index]

    def index
        @appointments = Appointment.all
        render json: @appointments,status: :ok
    end

    def create
        @appointment = Appointment.create!(prayer_params)
        render json: @appointment,status: :created
    end

    def destroy
        @appointment = Appointment.find(params[:id])
        @appointment.destroy
        head :no_content
    end

    def update
        @appointment = Appointment.find(params[:id])
        @appointment.update(prayer_params)
        render json: @prayer, status: :ok
    end

    private

    def set_prayer
        @prayer = Prayer.find(params[:id])
    end

    def appointment_params
        params.permit(:first_name,:second_name,:email,:phone_number,:reschedule,:title)
    end
end
