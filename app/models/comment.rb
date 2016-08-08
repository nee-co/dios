# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text(65535)      not null
#  event_id   :integer          not null
#  user_id    :integer          not null
#  posted_at  :datetime         not null
#  created_at :datetime
#  updated_at :datetime
#

class Comment < AldeaBase
  belongs_to :event
  belongs_to :user
end
