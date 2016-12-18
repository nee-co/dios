ActiveAdmin.register Caja::File do
  menu parent: 'Caja'

  actions :all, only: %i(index show)

  controller do
    def scoped_collection
      Caja::File.includes([:parent, :inserted_user, :updated_user])
    end
  end

  index title: 'File' do
    selectable_column
    id_column
    column :name
    column :group_id
    column :parent
    column :inserted_user
    column :updated_user
    actions
  end

  filter :id
  filter :name
  filter :group_id
  filter :parent
  filter :inserted_user
  filter :updated_user
  filter :inserted_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :name
      row :group_id
      row :parent
      row :inserted_user
      row :updated_user
      row :inserted_at
      row :updated_at
    end

    active_admin_comments
  end
end
