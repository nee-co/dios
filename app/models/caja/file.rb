# == Schema Information
#
# Table name: files
#
#  id          :string(36)       not null, primary key
#  parent_id   :string(36)       not null
#  group_id    :string(36)       not null
#  name        :string(50)       not null
#  inserted_by :integer          not null
#  inserted_at :datetime         not null
#  updated_by  :integer          not null
#  updated_at  :datetime         not null
#

class Caja::File < Caja::Base
  belongs_to :parent, class_name: Caja::Folder
  belongs_to :inserted_user, class_name: Cuenta::User, foreign_key: :inserted_by
  belongs_to :updated_user, class_name: Cuenta::User, foreign_key: :updated_by
end
