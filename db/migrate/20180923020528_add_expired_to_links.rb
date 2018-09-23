class AddExpiredToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :expired, :boolean
  end
end
