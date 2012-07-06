class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :global_settings, :site_categories

  def global_settings
    @global_settings ||= Setting.first
    @global_settings
  end

  def site_categories
    @categories ||= Category.all
  end
end
