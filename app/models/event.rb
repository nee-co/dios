class Event < AldeaBase
  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_many :users, through: :entries
  has_and_belongs_to_many :tags
end
