class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:show]
    skip_before_action :authorized, only: [:index, :create]
  
    def index
      @appointments = Appointment.all
      render json: @appointments, status: :ok
    end
  
    def create
      @appointment = Appointment.create!(appointment_params)
      render json: @appointment, status: :created
    end
  
    def destroy
      @appointment = Appointment.find(params[:id])
      @appointment.destroy
      head :no_content
    end
  
    def update
      @appointment = Appointment.find(params[:id])
      @appointment.update(appointment_params)  # Fixed: Use appointment_params here
      render json: @appointment, status: :ok   # Fixed: Use @appointment here
    end
  
    private
  
    def set_appointment
      @appointment = Appointment.find(params[:id])  # Fixed: Use @appointment here
    end
  
    def appointment_params
      params.permit(:first_name, :second_name, :email, :phone_number, :reschedule, :title)
    end
  end
  