# frozen_string_literal: true

class Person < ApplicationRecord
  has_one :personal_info, :dependent => :destroy #cascade
end
