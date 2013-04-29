class AddPassSessionIdToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :pass_session_id, :integer
    add_index :sessions, :pass_session_id
  end
end
