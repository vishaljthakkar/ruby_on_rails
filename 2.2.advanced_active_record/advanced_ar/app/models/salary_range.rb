# frozen_string_literal: true

class SalaryRange < ApplicationRecord
  belongs_to :job

  # built in :numericality can do this. But this is just to show as an example.
  validates_numericality_of :min_salary, less_than: :max_salary

end
