class AddColumnUserToMessage < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :user, index: true
  end
end
