require 'net/http'

# Thanks Ilya! http://www.igvita.com/2006/09/07/validating-url-in-ruby-on-rails/
# Original credits: http://blog.inquirylabs.com/2006/04/13/simple-uri-validation/
# HTTP Codes: http://www.ruby-doc.org/stdlib/libdoc/net/http/rdoc/classes/Net/HTTPResponse.html

class UriValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    raise(ArgumentError, "A regular expression must be supplied as the :format option of the options hash") unless options[:format].nil? or options[:format].is_a?(Regexp)
    configuration = { :message => "is invalid", :format => URI::regexp(%w(http https)) }
    configuration.update(options)

    if value =~ configuration[:format]
      true
    else
      object.errors.add(attribute, configuration[:message]) and false
    end
  end
end