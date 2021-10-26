class ReviewMovie < ApplicationRecord
  belongs_to :review, optional: true
  belongs_to :movie, optional: true
end
