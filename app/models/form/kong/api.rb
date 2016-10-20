class Form::Kong::Api
  include ActiveModel::Model

  PERMITTED_ATTRIBUTES = %i(id name request_path upstream_url plugins).freeze

  attr_accessor(*PERMITTED_ATTRIBUTES)

   validates :name, presence: true
   validates :request_path, presence: true, format: %r(\A/)
   validates :upstream_url, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
   validate :available_name
   validate :available_request_path

   def create
     ::Kong::Api.create(params)
     ::Kong::Api.find(self.name).sync_plugins(self.plugins.reject(&:blank?))
   end

   def update
     ::Kong::Api.update(params.merge(id: self.id))
     ::Kong::Api.find(self.name).sync_plugins(self.plugins.reject(&:blank?))
   end

   private

   def available_name
     self.errors.add(:name, "has already been taken") unless ::Kong::Api.name_available?(self.name, self.id)
   end

   def available_request_path
     self.errors.add(:request_path, "has already been taken") unless ::Kong::Api.request_path_available?(self.request_path, self.id)
   end

   def params
   {
     name: self.name,
     request_path: self.request_path,
     upstream_url: self.upstream_url
   }
   end
end
