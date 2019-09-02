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
  # get 'apply/:company/:exposure', to: 'applyform#apply'
  get 'application/:company/:exposure/:duration', to: 'applyform#apply'
  post 'apply', to: 'applyform#apply'

  # Dashboard
  get 'login', to: redirect('http://dashboard.moneyloop.com.au/admins/sign_in', status: 301)

  # Blog Engine with ButterCMS
  scope module: 'blog' do
    get '/categories/:slug' => 'categories#show', as: :buttercms_category
    get '/author/:slug' => 'authors#show', as: :buttercms_author

    get '/news/rss' => 'feeds#rss', format: 'rss', as: :buttercms_blog_rss
    get '/news/atom' => 'feeds#atom', format: 'atom', as: :buttercms_blog_atom
    get '/news/sitemap.xml' => 'feeds#sitemap', format: 'xml', as: :buttercms_blog_sitemap

    get '/news(/page/:page)' => 'posts#index', defaults: { page: 1 }, as: :buttercms_blog
    get '/news/:slug' => 'posts#show', as: :buttercms_post
  end

  get '/healthcheck', to: proc { [200, {}, ['']]}
  # Root address
  root 'static#home'

end
