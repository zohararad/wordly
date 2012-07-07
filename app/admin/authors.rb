ActiveAdmin.register Author do

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email, :as => :email
      f.input :website, :as => :url
      f.input :about
      #f.input :password
      #f.input :password_confirmation
    end
    f.buttons
  end

end
