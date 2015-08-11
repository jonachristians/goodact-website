class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :description
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
