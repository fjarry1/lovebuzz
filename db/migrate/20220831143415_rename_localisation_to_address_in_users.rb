class RenameLocalisationToAddressInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :localisation, :address
  end
end
