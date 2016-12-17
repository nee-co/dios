# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Aldea::Entry < Aldea::Base
  belongs_to :user, class_name: Cuenta::User
  belongs_to :event, class_name: Aldea::Event
end
