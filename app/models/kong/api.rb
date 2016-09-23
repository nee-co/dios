module Kong
  class Api < Flexirest::Base
    include Kong::ApiClient

    get :find, "/apis/:id"
    get :plugins, "/apis/:id/plugins"
    post :create, "/apis"
    patch :update, "/apis/:id"
    delete :delete, "/apis/:id"

    def self.all
      _request('/apis', :get).data
    end

    def plugins
      Kong::Plugin.list_per_api(api_id: id).data
    end
  end
end
