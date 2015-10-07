class AddImageToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :image, :string
  end
end
