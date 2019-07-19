Rails.application.routes.draw do
  # Static Pages
  get 'home/home', to: 'home#home'
  get 'about', to: 'about#about'
  get 'team', to: 'about#team'

  # Contact us form
  get 'contact', to: 'contact#index'
  post '/send_email', to: 'contact#send_email', as: 'send_email'

  # Application form
  get 'apply', to: 'applyform#apply'
  post 'apply', to: 'applyform#apply'  

  # Users
  devise_for :users

  # Blogging
  get '/blogs', to: redirect('https://blog.moneyloop.com.au', status: 301)
  # resources :blogs
  # post 'blogs/upload', to: 'blogs#upload'
 
  # Changing between consumer/insurer mode
  get 'insurer', to: 'home#insurer'

  # Dashboard
  get 'login', to: redirect('http://development-dashboard.moneyloop.com.au/admins/sign_in', status: 301)

  # FAQ
  get 'faq', to: 'home#faq'

  # Root address
  root 'home#home'

end
