class Configuration < ActiveRecord::Base
  set_table_name :configuration
  attr_accessible :settings

  serialize :settings
end
