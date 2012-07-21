require 'spec_helper'

describe Setting do

  before(:all) do
    @setting = Setting.new :configuration => Setting::DEFAULT_SETTINGS
  end

  it 'should have default getters with values from Setting::DEFAULT_SETTINGS' do
    Setting::DEFAULT_SETTINGS.each do |k, v|
      @setting.send(k.to_sym).should == v
    end
  end

  it 'should have default setters from Setting::DEFAULT_SETTINGS' do
    Setting::DEFAULT_SETTINGS.keys.each do |k|
      @setting.respond_to?("#{k}=").should == true
    end
  end

  it 'should set value in configuration hash when calling setter' do
    @setting.site_name = 'Some Name'
    @setting.configuration[:site_name].should == 'Some Name'
  end

end
