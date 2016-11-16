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
  filter :college, as: :check_boxes, collection: College.all

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

  # Import User
  action_item :only => :index do
    link_to "Import User", action: :upload_csv
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, method: :post do
    colleges = College.all
    current = DateTime.current

    users = ["Number", "Password"].to_csv
    CsvDb.convert_save(User, params[:dump][:file]) do |model, hash|
      number = hash[:number].downcase
      random_password = SecureRandom.hex(6)
      college = colleges.find { |c| c.code == number[4] }
      begin
        model.create(
          name: number,
          number: number.upcase,
          college_id: college.id,
          image_path: college.default_image_path,
          encrypted_password: BCrypt::Password.create(random_password),
          inserted_at: current,
          updated_at: current
        )
        users << [number, random_password].to_csv
      rescue => e
        Rails.logger.error e
      end
    end
    send_data users, filename: "#{Time.current.strftime('%Y%m%d')}_import_users.csv"
  end
end
