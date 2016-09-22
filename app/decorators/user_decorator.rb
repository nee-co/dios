class UserDecorator < Draper::Decorator
  delegate_all

  delegate :name, to: :college, prefix: true, allow_nil: true

  def number
    model.number.upcase
  end
end
