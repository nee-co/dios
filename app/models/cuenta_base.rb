# frozen_string_literal: true
class CuentaBase < ActiveRecord::Base
  establish_connection configurations["#{Rails.env}_cuenta"]
  self.abstract_class = true
end
