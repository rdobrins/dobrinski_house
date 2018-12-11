class CreateClusters < ActiveRecord::Migration[5.2]
  def change
    create_table :clusters do |t|
      t.string :stamp
      t.integer :number_of_fragments
      t.integer :total_character_count
      t.timestamps
    end
  end
end
