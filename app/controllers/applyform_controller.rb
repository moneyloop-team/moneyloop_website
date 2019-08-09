require 'net/http'
require 'browser/aliases'
Browser::Base.include(Browser::Aliases)

class ApplyformController < ApplicationController
  def success
  end
  def error
  end

  def apply
    # Get the company from the GET url params
    @exposure = params['exposure']
    id = params['company']
    response = getCompany(id)
    if(response.code == "200")
      @company = JSON(response.body)
    else
      @error_msg = "Unable to find your Insurer"
      render :error
    end

    # The customer has submitted an application form, let's create a new customer
    if request.post?
      get_request_params request    # Get the parameters required that the user didn't supply
      response = create_customer()  # Send user data to the dashboard and save the response
      response = JSON(response.body)
      if response['code'] == "200"  # Send the appropriate response
        @notice = response['credit_score']
        render :success
      else
        @error_code = response['code']
        @error_body = response['body']
        render :error
      end
    end
  end

  private
  # Get the company
  def getCompany(id)
    uri = URI.parse("http://157.230.242.156/getCompany/#{id}")
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
  def create_customer
    uri = URI.parse("http://157.230.242.156/create_customer")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Postman-Token"] = "c3bf8176-37dc-4ba3-ad8e-a8de8f92befa"
    request["Cache-Control"] = "no-cache"
    request.body = JSON.dump({
      "uuid": "1",
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
      "time_zone": params[:time_zone],
      "time_of_day": @time,
      "australian_resident": "true",
      "duration": params[:duration]
      })
      byebug
      req_options = {
        use_ssl: uri.scheme == "https",
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
  end
end
