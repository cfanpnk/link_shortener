class ChangeExpiredDefaultToFalse < ActiveRecord::Migration[5.1]
  def change
    change_column_default :links, :expired, false
  end
end
