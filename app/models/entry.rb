# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Entry < AldeaBase
  belongs_to :user
  belongs_to :event
end
