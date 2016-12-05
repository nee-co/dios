# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  number             :string(9)        not null
#  encrypted_password :string(255)      not null
#  college_id         :integer
#  image              :string(255)      default(""), not null
#  note               :string(255)      default(""), not null
#  inserted_at        :datetime         not null
#  updated_at         :datetime         not null
#

class User < CuentaBase
  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_many :events, through: :entries
  belongs_to :college
end
