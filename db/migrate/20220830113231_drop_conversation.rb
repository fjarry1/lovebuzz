class DropConversation < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :conversation_id
    add_reference :messages, :match, index: true
    drop_table :conversations
  end
end
