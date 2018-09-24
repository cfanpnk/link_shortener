class AddUniqueIndexToHashKey < ActiveRecord::Migration[5.1]
  def change
    add_index :links, :hash_key, unique: true
  end
end
