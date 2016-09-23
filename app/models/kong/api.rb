module Kong
  class Api < Flexirest::Base
    include Kong::ApiClient

    get :find, "/apis/:id"
    post :create, "/apis"
    patch :update, "/apis/:id"
    delete :delete, "/apis/:id"

    def self.all
      _request('/apis', :get).data
    end
  end
end
