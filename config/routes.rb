Rails.application.routes.draw do
  # Static Pages
  get 'home', to: 'static#home'
  get 'about', to: 'static#about'
  get 'team', to: 'static#team'
  get 'insurer', to: 'static#insurer'
  get 'faq', to: 'static#faq'

  # Contact us form
  get 'contact', to: 'contact#contact'
  post 'send_email', to: 'contact#send_email', as: 'send_email'

  # Application form
  get 'apply', to: 'applyform#apply'
  post 'apply', to: 'applyform#apply'  

  # Dashboard
  get 'login', to: redirect('http://dashboard.moneyloop.com.au/admins/sign_in', status: 301)

  # Root address
  root 'static#home'

end
