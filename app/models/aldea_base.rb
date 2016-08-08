# frozen_string_literal: true
class AldeaBase < ActiveRecord::Base
  establish_connection configurations["aldea"]
  self.abstract_class = true
end
