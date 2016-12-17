# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  number             :string(9)        not null
#  encrypted_password :string(255)      not null
#  college_id         :integer
#  image              :string(255)      not null
#  note               :string(255)      default(""), not null
#  inserted_at        :datetime         not null
#  updated_at         :datetime         not null
#

class Cuenta::User < Cuenta::Base
  has_many :comments, class_name: Aldea::Comment, dependent: :delete_all
  has_many :entries, class_name: Aldea::Entry,  dependent: :delete_all
  has_many :events, class_name: Aldea::Event, through: :entries
  belongs_to :college, class_name: Cuenta::College
end
