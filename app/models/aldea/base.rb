# frozen_string_literal: true
class Aldea::Base < ActiveRecord::Base
  establish_connection configurations['aldea']
  self.abstract_class = true
end
