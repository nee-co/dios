module Kong::ApiClient
  extend ActiveSupport::Concern

  included do
    base_url Settings.kong_url
    request_body_type :json
    perform_caching false
    whiny_missing true
  end

  class_methods do
  end
end
