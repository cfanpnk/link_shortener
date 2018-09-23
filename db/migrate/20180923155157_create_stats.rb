class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.references :link, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
