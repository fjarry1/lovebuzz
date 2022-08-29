class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :gender, :string
    add_column :users, :localisation, :string
    add_column :users, :description, :text
    add_column :users, :music_tastes, :string
  end
end
