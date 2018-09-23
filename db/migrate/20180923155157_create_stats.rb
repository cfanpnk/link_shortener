class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.references :link, foreign_key: true
      t.integer :count, null: false, default: 0

      t.timestamps
    end
  end
end
