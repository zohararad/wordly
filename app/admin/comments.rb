ActiveAdmin.register Comment do

  index do
    column :created_at
    column :author_name
    column :author_email
    column :comment
    default_actions
  end

end
