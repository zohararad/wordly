require 'digest/md5'
module ApplicationHelper

  def gravatar_image(email, size = '32x32')
    hash = Digest::MD5.hexdigest(email.downcase)
    image_src = "%s://www.gravatar.com/avatar/#{hash}?s=#{size}" % (request.ssl? ? 'https' : 'http')
    image_tag(image_src, :class => 'gravatar')
  end

end
