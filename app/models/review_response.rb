class ReviewResponse < ApplicationRecord
  belongs_to :review, optional: true
  belongs_to :response, optional: true
end
