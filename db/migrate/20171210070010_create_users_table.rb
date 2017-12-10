class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users_tables do |t|
      t.string :name
      t.string :email_address
      t.string :password_digest
    end
  end
end
