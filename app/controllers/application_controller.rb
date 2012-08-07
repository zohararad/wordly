class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepend_view_paths
  helper_method :global_settings, :site_categories, :theme

  def global_settings
    Wordly::Settings
  end

  def site_categories
    @categories ||= Category.all
  end

  def theme
    global_settings.theme
  end

  def prepend_view_paths
    prepend_view_path Rails.root.join('vendor','themes',theme,'views')
  end

end
