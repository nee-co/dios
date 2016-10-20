module Kong
  class Plugin < Flexirest::Base
    include Kong::ApiClient

    PERMITTED_PLUGINS = %i(jwt cors).freeze

    get :list_per_api, "/apis/:api_id/plugins"
    get :schema, "/plugins/schema/:name"
    delete :delete, "apis/:api_id/plugins/:id"

    def self.all
      _request('/plugins/enabled', :get).enabled_plugins.map { |name| self.new(name: name) }
    end

    def schema
      self.class.schema(name: name)
    end

    def delete
      self.class.delete(api_id: api_id, id: id)
    end
  end
end
