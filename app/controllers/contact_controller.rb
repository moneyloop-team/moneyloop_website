class ContactController < ApplicationController
  layout 'mailer'

  def index
  end

  def send_email
    ContactMailer.send_email(name: params[:name], email: params[:email], phone: params[:phone], message: params[:message]).deliver
    redirect_to contact_path, notice: "Thank you for reaching out! We will contact you shortly."
  end
end
