# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  body       :text(65535)      not null
#  owner_id   :integer          not null
#  start_date :date             not null
#  is_public  :boolean          default(FALSE), not null
#  image      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Aldea::Event < Aldea::Base
  has_many :comments, class_name: Aldea::Comment, dependent: :delete_all
  has_many :entries, class_name: Aldea::Entry, dependent: :delete_all
  belongs_to :owner, class_name: Cuenta::User
end
