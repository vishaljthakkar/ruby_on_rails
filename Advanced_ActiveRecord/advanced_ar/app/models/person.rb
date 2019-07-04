# frozen_string_literal: true

class Person < ApplicationRecord
  has_one :personal_info, :dependent => :destroy #cascade
  has_many :jobs, :dependent => :nullify
  # This is just an alias created to a model named Job
  has_many :my_jobs, class_name: 'Job'
  has_and_belongs_to_many :hobbies
end
