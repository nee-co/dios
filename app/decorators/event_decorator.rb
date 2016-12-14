class EventDecorator < Draper::Decorator
  delegate_all
  decorates_association :comments

  delegate :name, to: :owner, prefix: true, allow_nil: true
end
