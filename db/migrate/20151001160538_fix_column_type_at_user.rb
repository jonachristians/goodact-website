class FixColumnTypeAtUser < ActiveRecord::Migration
  def up
    change_column :users, :image, :string
    change_column :offers, :image, :string
  end
  def down
    change_column :users, :image, :text
    change_column :offers, :image, :text
  end
end
