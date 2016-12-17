# frozen_string_literal: true
class Caja::Base < ActiveRecord::Base
  establish_connection configurations["caja"]
  self.abstract_class = true
end
