class CommentDecorator < Draper::Decorator
  delegate_all

  delegate :name, to: :user, prefix: true, allow_nil: true
end
