class AddSpotifyColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :spotify_token, :string
    add_column :users, :token, :string
    add_column :users, :spotify_id, :string
    add_column :users, :spotify_hash, :text
    add_column :users, :spotify_track_id, :string
  end
end
