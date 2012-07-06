ActiveAdmin.register Setting, :as => 'Settings' do

  form do |f|
    f.inputs *Setting::DEFAULT_SETTINGS.keys
    f.buttons
  end

  show :title => 'Site Settings' do |s|
    attributes_table do
      s.configuration.keys.each do |k|
        row k do
          s.configuration[k]
        end
      end
    end
  end

  controller do

    def index
      s = Setting.first
      redirect_to :action => 'show', :id => s.id
    end

  end

end
