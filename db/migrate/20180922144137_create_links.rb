class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :original_link, null: false
      t.string :hash_key, null: false

      t.timestamps
    end
  end
end
