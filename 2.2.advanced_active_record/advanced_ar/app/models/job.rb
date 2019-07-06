# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :person
  has_one :salary_range

  validates :title, :company, presence: true
end
