class AddZipAndUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :zipcode, :integer
    add_column :users, :username, :string
  end
end
