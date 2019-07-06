class Book < ApplicationRecord
  # if optional: true is not specified then rake db:seed will fail and would require us to have reviewers
  #
  belongs_to :reviewer, optional: true
  has_many :notes, dependent: :destroy
end
