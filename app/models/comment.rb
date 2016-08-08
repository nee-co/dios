class Comment < AldeaBase
  belongs_to :event
  belongs_to :user
end
