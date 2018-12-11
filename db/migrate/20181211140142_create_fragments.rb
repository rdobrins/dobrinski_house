class CreateFragments < ActiveRecord::Migration[5.2]
  def change
    create_table :fragments do |t|
      t.references :cluster
      t.integer :cluster_order
      t.text :content
      t.timestamps
    end
  end
end
