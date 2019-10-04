require 'rails_helper'

RSpec.describe DistancePoint, type: :model do
  it "shows as invalid when created a distance_point with a distance out of range" do
    invalid_distance_point = DistancePoint.new({ origin: "A",destination: "B",distance: 1003333 })
    expect(invalid_distance_point.valid?).to eq(false)
  end
end
