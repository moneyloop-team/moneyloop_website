class ContactMailer < ApplicationMailer
    def send_email(options={})
        @name = options[:name]
        @email = options[:email]
        @phone = options[:phone]
        @message = options[:message]
        mail(:to=>"contact@moneyloop.com.au", :subject=>"MoneyLoop Contact Form")
    end
end
