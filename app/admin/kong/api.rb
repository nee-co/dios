ActiveAdmin.register_page 'Kong' do

  content do
    columns do
      column do
        panel 'API List' do
          table_for Kong::Api.all do
            column :id
            column :name
            column :request_path
            column :upstream_url
            column(:plugins) { |api| api.plugins.map(&:name).join(' ') }
          end
        end
      end
    end
  end
end
