ActiveAdmin.register Page do

  form :partial => "form"

  index do
    column :title
    column :author
    column :created_at
    default_actions
  end

end
