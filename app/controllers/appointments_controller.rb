class AppointmentsController < ApplicationController
    before_action :set_appointment, only: [:show,:destroy]
    skip_before_action :authorized, only: [:index, :create]
  
    def index
      @appointments = Appointment.all
      render json: @appointments, status: :ok
    end
  
    def create
      @appointment = Appointment.create!(appointment_params)
      if @appointment.save
        AppointmentMailer.with(appointment: @appointment).new_appointment_email.deliver_later
         # flash[:success] = "Thank you for your order! We'll get in touch with you soon!"
         # redirect_to root_path
       else
         # flash.now[:error] = "Your order form had some errors. Please check the form and resubmit."
         render :new, status: :unprocessable_entity
       end
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
      params.permit(:fullname, :email, :phone_number, :reschedule, :title)
    end
  end
  