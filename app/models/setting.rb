class Setting < ActiveRecord::Base
  attr_accessible :configuration
  serialize :configuration

  after_initialize :add_configuration_accesors

  DEFAULT_SETTINGS = {
    :site_name => 'Another Wordly Site'
  }

  private

  def add_configuration_accesors
    self.configuration.merge!(DEFAULT_SETTINGS)
    self.configuration.each do |k,v|
      self.class_eval do
        define_method("#{k}") do
          if self.configuration && !self.configuration[k].nil?
            self.configuration[k]
          else
            v
          end
        end

        define_method("#{k}=") do |value|
          self.configuration[k] = value
        end
      end
    end
  end

end
