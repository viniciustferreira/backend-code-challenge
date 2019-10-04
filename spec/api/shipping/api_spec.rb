require 'rails_helper'

RSpec.describe Shipping::API do
  context "inserting distance between locations" do
    it "inserts a correct distance between A anb B into the system" do
      post "/distance", params: { origin: "A", destination: "B", distance: 100 }
      expect(response.body).to eq(DistancePoint.last.id.to_s)
    end

    it "tries to create a distance greater than 100000 between A and B locations" do
      post "/distance", params: { origin: "A", destination: "B", distance: 100010 }
      expect(response.code).to eq("400")
    end

    it "replaces a existing distance between A and B" do
      DistancePoint.create(origin: "A", destination: "B", distance: 10)
      post "/distance", params: { origin: "A", destination: "B", distance: 100 }
      expect(response.body).to eq(DistancePoint.last.id.to_s)
    end
  end

  context "sending response with the calculated cost of a product" do
    it "sends a coordenation and weight to get the cost of transportation" do
      DistancePoint.create(origin: "A", destination: "B", distance: 10)
      get "/cost", params: { origin: "A", destination: "B", weight: 10 }

      calculated_cost = 10 * 10 * 0.15 
      expect(response.body).to eq(calculated_cost.to_s)
    end

    it "gives an error to the user when its trying to recover a cost with weight greater than 50" do 
      get "/cost", params: { origin: "A", destination: "B", weight: 550 }
      expect(response.code).to eq("400")
    end

    it "gives an blank response when not find a location" do 
      get "/cost", params: { origin: "A", destination: "Z", weight: 50 }
      expect(response.body).to eq("")
    end

    it "returns the minimum cost between A and B and they are not directed linked" do
      DistancePoint.create(origin: "A", destination: "B", distance: 10)
      DistancePoint.create(origin: "B", destination: "C", distance: 15)
      DistancePoint.create(origin: "A", destination: "C", distance: 30)

      get "/cost", params: { origin: "A", destination: "C", weight: 5 }

      calculated_cost = 25 * 5 * 0.15 
      expect(response.body).to eq(calculated_cost.to_s)
    end
  end
end