# frozen_string_literal: true

class Reviewer < ApplicationRecord
  has_secure_password

  has_many :books
end
