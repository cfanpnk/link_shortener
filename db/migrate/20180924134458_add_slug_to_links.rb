class AddSlugToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :slug, :string, null: false, default: "default"
    add_index :links, :slug, unique: true
  end
end
