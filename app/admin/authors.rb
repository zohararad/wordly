ActiveAdmin.register Author do

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email, :as => :email
      f.input :website, :as => :url
      f.input :about
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end

  index do
    column :full_name
    default_actions
  end

  controller do

    def update
      if params[:author][:password].blank? or params[:author][:password_confirmation].blank?
        params[:author].delete(:password)
        params[:author].delete(:password_confirmation)
      end
      super
    end

  end

end
