require 'digest/md5'
module ApplicationHelper

  def gravatar_image(email, size = '32x32')
    hash = Digest::MD5.hexdigest(email.downcase)
    image_src = "%s://www.gravatar.com/avatar/#{hash}?s=#{size}" % (request.ssl? ? 'https' : 'http')
    image_tag(image_src, :class => 'gravatar')
  end

  def current?(o)
    case o.class.name.to_s
      when 'Page'
        o == @page
      when 'Category'
        o == @category
      when 'String'
        request.path == o
    end
  end

end
