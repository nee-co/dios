# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text(65535)      not null
#  event_id   :integer          not null
#  user_id    :integer          not null
#  posted_at  :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < AldeaBase
  belongs_to :event
  belongs_to :user
end
