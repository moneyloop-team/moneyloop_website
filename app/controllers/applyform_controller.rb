require 'net/http'
require 'browser/aliases'
Browser::Base.include(Browser::Aliases)

class ApplyformController < ApplicationController
  def success
  end
  def error
  end

  def apply
    # redirect_to('https://moneyloop.com.au/application/'+params[:company]+'/'+params[:exposure]+'/'+params[:duration]) and return
    if request.post? == false# The customer has submitted something
      # They've submitted credit card information, let's add it
      # Get the company from the GET url params
      @exposure = params['exposure']
      $id = params[:company]
      response = getCompany($id)
      if(response.code == "200")
        @company = JSON(response.body)
      else
        @error_msg = "Unable to find your Insurer"
        render :error and return
      end
     else
      if request.request_parameters["creditCardToken"].nil? == false
        card_response = create_payment(params[:creditCardToken], $customer['id'], $customer["company_id"], 2)
        if card_response.code == "200"
          @notice = "Card Added Successfully"
          @company_name =  getCompany( $customer["company_id"])['name']
          render js: "$('#myModal').modal('hide');document.getElementById('add_payment').style.display='none';document.getElementById('source_added').style.display='block';" and return
        # TODO - add the fail case here
        end
      # They've submitted their customer details, lets add that
      else
        # Get the company from the GET url params
        @exposure = params['exposure']
        response = getCompany($id)
        if(response.code == "200")
          @company = JSON(response.body)
        else
          @error_msg = "Unable to find your Insurer"
          render :error and return
        end
        get_request_params request    # Get the parameters required that the user didn't supply
        response = create_customer($id)  # Send user data to the dashboard and save the response
        response_customer = JSON(response.body)
        if response.code == "201"  # Send the appropriate response
          $customer = response_customer
          @notice = response_customer['credit_score']
          render :success and return
        else
          @error_code = response['code']
          @error_body = response['body']
          render :error and return
          end
        end
    end
end
  private
  # Get the company
  def getCompany(id)
    uri = URI.parse("https://dashboard.moneyloop.com.au/getCompany/#{id}")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Postman-Token"] = "c3bf8176-37dc-4ba3-ad8e-a8de8f92befa"
    request["Cache-Control"] = "no-cache"
      req_options = {
        use_ssl: uri.scheme == "https",
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      response.code
      response.body
      return response
  end

  # Get parameters from the request that weren't supplied by the user
  def get_request_params(request)
    browser = Browser.new(request.user_agent)   # User agent parser
    @dob = params[:dobday] + params[:dobmonth] + params[:dobyear]
    @location = "10.23.5.7" #request.ip # The user's IP address
    @type = if browser.mobile? then "mobile"      # is Mobile
            elsif browser.tablet? then "tablet"   # is Tablet
            else "desktop"
            end
    @os = if browser.platform.windows? then "windows"     # is Windows
          elsif browser.platform.mac? then "macintosh"    # is OSX
          elsif browser.platform.android? then "android"  # is Android
          elsif browser.platform.ios? then "ios"          # is iOS
          else "other"
          end
    @model = "Other"  # TODO
    @provider = "telstra" #TODO
    @time = DateTime.now.strftime("%H:%M")
  end

  # Send a JSON request to the dashboard
  def create_customer(id)
    uri = URI.parse("http://dashboard.moneyloop.com.au/create_m8srates/"+id)
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Postman-Token"] = "c3bf8176-37dc-4ba3-ad8e-a8de8f92befa"
    request["Cache-Control"] = "no-cache"
    request.body = JSON.dump({
      "exposure": params[:exposure],
      "given_names": params[:first_name],
      "surname": params[:last_name],
      "email": params[:email],
      "phone_mobile": params[:mobile],
      "phone_home": params[:mobile],
      "dob": @dob,
      "address": params[:address],
      "employer_name": params[:employer],
      "job_title": params[:Employment_Type],
      "device_type": @type,
      "device_os": @os,
      "device_model": @model,
      "device_screen_resolution": params[:resolution],
      "network_service_provider": @provider,
      "ip_address": @location,
      "time_zone": "+1000",
      "time_of_day": @time,
      "australian_resident": "true",
      "duration": params[:duration]
      })
      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      return response
  end

  def create_payment(creditCardToken, id, company_id, duration)
    uri = URI.parse("http://dashboard.moneyloop.com.au//create_payment/")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Postman-Token"] = "c3bf8176-37dc-4ba3-ad8e-a8de8f92befa"
    request["Cache-Control"] = "no-cache"
    request.body = JSON.dump({
      "creditCardToken" => creditCardToken,
      "customer_id" => id,
      "establishment_fee" => 1,
      "company_id" => company_id,
      "duration" => duration
      })
    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response.code
    response.body
    return response
  end
end
