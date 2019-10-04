class DistancePoint < ApplicationRecord
  validates :distance, :inclusion => 0..100000
end
