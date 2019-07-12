class BlogScrubber < Rails::Html::PermitScrubber
    def initialize
      super
      self.tags = %w( strong em a h1 h2 p br img )
      self.attributes = %w( href src )
    end
  end