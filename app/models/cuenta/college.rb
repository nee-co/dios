# == Schema Information
#
# Table name: colleges
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  code        :string(1)        not null
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#

class Cuenta::College < Cuenta::Base
  has_many :users, class_name: Cuenta::User
end
