class ChangeMatchIdIdIntoMatch < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :match_id_id, :match_id
  end
end
