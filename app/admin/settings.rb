ActiveAdmin.register Setting, :as => 'Settings' do

  form do |f|
    f.inputs *Setting::DEFAULT_SETTINGS.keys
    f.buttons
  end

  show :title => 'Site Settings' do |s|
    attributes_table do
      row :site_name do
        s.configuration[:site_name]
      end
      row :theme do
        s.configuration[:theme]
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
