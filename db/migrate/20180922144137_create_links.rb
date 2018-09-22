class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :original_link
      t.string :hash_key

      t.timestamps
    end
  end
end
