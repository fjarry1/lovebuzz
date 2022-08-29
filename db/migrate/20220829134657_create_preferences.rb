class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :min_age
      t.integer :max_age
      t.string :gender
      t.float :max_distance

      t.timestamps
    end
  end
end
