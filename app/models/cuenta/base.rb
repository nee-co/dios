# frozen_string_literal: true
class Cuenta::Base < ActiveRecord::Base
  establish_connection configurations["cuenta"]
  self.abstract_class = true
end
