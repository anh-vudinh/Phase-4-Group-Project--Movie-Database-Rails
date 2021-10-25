class ReviewMovie < ApplicationRecord
  belongs_to :review
  belongs_to :movie
end
