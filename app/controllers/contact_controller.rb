class ContactController < ApplicationController
  layout 'mailer'

  def contact
  end

  def send_email
    flash[:notice] = "Thank you for reaching out! We will contact you shortly."
    ContactMailer.send_email(name: params[:name], email: params[:email], phone: params[:phone], message: params[:message]).deliver
    redirect_to contact_path
  end
end
