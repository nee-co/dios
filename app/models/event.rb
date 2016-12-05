# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  body              :text(65535)
#  register_id       :integer          not null
#  started_at        :datetime
#  ended_at          :datetime
#  venue             :string(255)
#  entry_upper_limit :integer
#  status            :integer          default(0), not null
#  image             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Event < AldeaBase
  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_many :users, through: :entries
  has_and_belongs_to_many :tags
end
