ActiveAdmin.register Cuenta::User do
  menu parent: 'Cuenta'

  decorate_with Cuenta::UserDecorator

  actions :all, except: %i(new create)

  permit_params :number, :name, :college_id

  config.sort_order = 'id_asc'

  controller do
    def scoped_collection
      Cuenta::User.includes(:college)
    end
  end

  index title: 'User' do
    selectable_column
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
  filter :college, as: :check_boxes, collection: Cuenta::College.all

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
    f.semantic_errors(*f.object.errors.keys)
    inputs 'User' do
      input :name, required: true
      input :number, required: true
      input :college, required: true
    end
    actions
  end

  # Import User
  action_item only: :index do
    link_to 'Import User', action: :upload_csv
  end

  collection_action :upload_csv do
    render 'admin/csv/upload_csv'
  end

  collection_action :import_csv, method: :post do
    colleges = Cuenta::College.all
    current = DateTime.current

    users = %w(Number Password).to_csv
    CsvDb.convert_save(Cuenta::User, params[:dump][:file]) do |model, hash|
      number = hash[:number].downcase
      random_password = SecureRandom.hex(6)
      college = colleges.find { |c| c.code == number[4] }
      image_name = Imagen::Image.upload(File.open(Rails.root.join("files/images/#{number[4]}.png")))

      begin
        model.create(
          name: hash[:name],
          number: number.upcase,
          college_id: college.id,
          image: image_name,
          encrypted_password: BCrypt::Password.create(random_password),
          inserted_at: current,
          updated_at: current
        )
        users << [number, random_password].to_csv
      rescue => e
        Rails.logger.error e
        Imagen::Image.delete(image_name: image_name)
      end
    end
    send_data users, filename: "#{Time.current.strftime('%Y%m%d')}_import_users.csv"
  end
end
