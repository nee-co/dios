ActiveAdmin.register User do
  decorate_with UserDecorator

  actions :all, except: %i(new create)

  permit_params :number, :name, :college_id

  config.sort_order = 'id_asc'

  index title: 'User' do
    id_column
    column '学籍番号', :number
    column '氏名', :name
    column 'カレッジ', :college_name
    column '登録日時', :inserted_at
    actions
  end

  filter :id, label: 'ID'
  filter :number, label: '学籍番号'
  filter :name, label: '氏名'
  filter :college, as: :check_boxes, label: 'カレッジ', collection: -> { College.all }

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
