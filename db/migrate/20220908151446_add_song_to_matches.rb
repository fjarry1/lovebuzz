class AddSongToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :song, :string, default: ''
  end
end
