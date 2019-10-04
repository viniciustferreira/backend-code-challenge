class CreateDistancePoint < ActiveRecord::Migration[5.2]
  def change
    create_table :distance_points do |t|
      t.string :origin, index: true
      t.string :destination, index: true
      t.integer :distance
    end
  end
end
