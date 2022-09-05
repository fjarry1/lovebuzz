class AddColumnToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :status, :string, default: "Pending"
  end
end
