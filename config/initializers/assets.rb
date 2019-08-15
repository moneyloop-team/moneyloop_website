# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Add all the asset stylesheets and scripts in app/assets/stylesheets and app/assets/javascripts
Rails.application.config.assets.precompile += %w( material/*.css material/*.js )

# Add contoller-specific stylesheets and scripts in app/assets/stylesheets
Rails.application.config.assets.precompile += %w( static.css static.js)
Rails.application.config.assets.precompile += %w( about.css about.js)
Rails.application.config.assets.precompile += %w( contact.css contact.js)
Rails.application.config.assets.precompile += %w( applyform.css applyform.js)
Rails.application.config.assets.precompile += %w( blogs.css blogs.js)
Rails.application.config.assets.precompile += %w( devise/*.css devise/*.js)