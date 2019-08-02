class HomeController < ApplicationController
  def home
  end

  def about
  end

  def team
  end

  def insurer
  end

  def faq
  end

  def consumer
    if cookies[:consumer] == 'true'
      # Go to insurer mode
      cookies[:consumer] = false
    else
      # Go to consumer mode
      cookies[:consumer] = true
    end

    redirect_back fallback_location: root_path
  end
end
