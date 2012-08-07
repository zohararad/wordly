class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepend_view_paths
  helper_method :global_settings, :site_categories, :site_pages

  def global_settings
    Wordly::Settings
  end

  def site_categories
    @site_categories ||= Category.all
  end

  def site_pages
    @site_pages ||= Page.all
  end

  def prepend_view_paths
    prepend_view_path Rails.root.join('vendor','themes',global_settings.theme,'views')
  end

end
