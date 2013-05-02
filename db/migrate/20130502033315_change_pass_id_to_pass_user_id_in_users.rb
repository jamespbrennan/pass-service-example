class ChangePassIdToPassUserIdInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :pass_id, :pass_user_id
  end
end
