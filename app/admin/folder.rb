ActiveAdmin.register Caja::Folder do
  menu parent: "Caja"

  actions :all, only: %i(index show)

  controller do
    before_filter only: :index do
      if params[:commit].blank? && params[:q].blank?
        extra_params = {"q" => { parent_id_eq: 0 }}
        params.merge! extra_params
      end
    end

    def scoped_collection
      Caja::Folder.includes([:parent, :inserted_user, :updated_user])
    end
  end

  index title: 'Folder' do
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
  filter :parent, default: 0
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

    panel "Elements" do
      table_for caja_folder.folders do
        column(:name) do |folder|
          link_to folder.name, admin_caja_folder_path(folder.id)
        end
        column :inserted_user
        column :inserted_at
        column :updated_user
        column :updated_at
      end

      table_for caja_folder.files do
        column(:name) do |file|
          link_to file.name, admin_caja_file_path(file.id)
        end
        column :inserted_user
        column :inserted_at
        column :updated_user
        column :updated_at
      end
    end

    active_admin_comments
  end
end
