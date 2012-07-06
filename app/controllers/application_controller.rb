class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :global_settings

  def global_settings
    @global_settings ||= Setting.first
    @global_settings
  end
end
