ActiveAdmin.register User do
  decorate_with UserDecorator

  actions :all, except: %i(new create)

  permit_params :number, :name, :college_id

  config.sort_order = 'id_asc'

  index title: 'User' do
    id_column
    column :number
    column :name
    column :college_name
    column :inserted_at
    actions
  end

  filter :id
  filter :number
  filter :name
  filter :college, as: :check_boxes, collection: -> { College.all }

  show do
    attributes_table do
      row :id
      row :number
      row :name
      row :college_name
      row :inserted_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs 'User' do
      input :name, required: true
      input :number, required: true
      input :college, required: true
    end
    actions
  end
end
