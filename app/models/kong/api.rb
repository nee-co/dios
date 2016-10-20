module Kong
  class Api < Flexirest::Base
    include Kong::ApiClient

    get :find, "/apis/:id"
    get :plugins, "/apis/:id/plugins"
    post :add_plugin, "/apis/:id/plugins"
    delete :delete_plugin, "/apis/:api_id/plugins/:plugin_id"
    post :create, "/apis"
    patch :update, "/apis/:id"
    delete :delete, "/apis/:id"

    def self.all
      _request('/apis', :get).data
    end

    def self.name_available?(name, id)
      if id.present?
        ::Kong::Api.find(name).id == id
      else
        ::Kong::Api.find(name)
        false
      end
    rescue Flexirest::HTTPNotFoundClientException
      true
    end

    def self.request_path_available?(request_path, id)
      if id.present?
        ::Kong::Api.all.select { |api| api.request_path == request_path && api.id != id }.empty?
      else
        ::Kong::Api.all.select { |api| api.request_path == request_path }.empty?
      end
    end

    def sync_plugins(expected_plugins)
      current_plugins = self.plugins.map(&:name)
      delete_plugins(current_plugins - expected_plugins)
      add_plugins(expected_plugins - current_plugins)
    end

    def plugins
      Kong::Plugin.list_per_api(api_id: id).data
    end

    private

    def add_plugins(plugin_names)
      plugin_names.each do |plugin|
        params = { id: self.id, name: plugin }.merge(::Kong::Api.send("#{plugin}_params"))
        ::Kong::Api.add_plugin(params)
      end
    end

    def delete_plugins(plugin_names)
      plugins.select { |plugin| plugin_names.include?(plugin.name) }.each do |plugin|
        ::Kong::Api.delete_plugin(api_id: self.id, plugin_id: plugin.id)
      end
    end

    def self.jwt_params
      {
        "config.claims_to_verify": "exp"
      }
    end
    private_class_method :jwt_params

    def self.cors_params() {} end
    private_class_method :cors_params
  end
end
