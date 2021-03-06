# frozen_string_literal: true

class Person < ApplicationRecord
  has_one :personal_info, :dependent => :destroy #cascade
  has_many :jobs, :dependent => :nullify
  # This is just an alias created to a model named Job
  has_many :my_jobs, class_name: 'Job'
  has_and_belongs_to_many :hobbies
  has_many :approx_salaries, through: :jobs, source: :salary_range

  default_scope { order :first_name }
  # For an instance of a person, what is his max salary.
  # take approx_salaries array, then calculate maximum of those
  # and maximum should be using the max_salary column of salary_range
  def max_salary
    approx_salaries.maximum(:max_salary)
  end

  # SCOPE has to return Active Record Relation vs Classmethod style max_salary above
  # scope :ordered_by_age, -> { order(age: :desc) }
  scope :ordered_by_age, -> { order age: :desc }
  scope :starts_with, ->(starting_string){ where('first_name LIKE ?', "#{starting_string}%") }
end
