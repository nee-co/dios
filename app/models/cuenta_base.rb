# frozen_string_literal: true
class CuentaBase < ActiveRecord::Base
  establish_connection configurations["cuenta"]
  self.abstract_class = true
end
