class Form::Kong::Api
  include ActiveModel::Model

  PERMITTED_ATTRIBUTES = %i(id name request_path upstream_url plugins).freeze

  attr_accessor(*PERMITTED_ATTRIBUTES)

  validates :name, presence: true
  validates :request_path, presence: true, format: %r{\A/}
  validates :upstream_url, presence: true, format: /\A#{URI.regexp(%w(http https))}\z/
  validate :available_name
  validate :available_request_path

  def create
    ::Kong::Api.create(params)
    ::Kong::Api.find(name).sync_plugins(plugins.reject(&:blank?))
  end

  def update
    ::Kong::Api.update(params.merge(id: id))
    ::Kong::Api.find(name).sync_plugins(plugins.reject(&:blank?))
  end

  private

  def available_name
    errors.add(:name, 'has already been taken') unless ::Kong::Api.name_available?(name, id)
  end

  def available_request_path
    errors.add(:request_path, 'has already been taken') unless ::Kong::Api.request_path_available?(request_path, id)
  end

  def params
    {
      name: name,
      request_path: request_path,
      upstream_url: upstream_url
    }
  end
end
