# frozen_string_literal: true
class AldeaBase < ActiveRecord::Base
  establish_connection configurations["#{Rails.env}_aldea"]
  self.abstract_class = true
end
