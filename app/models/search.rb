class Search < ActiveRecord::Base
  validates :description, presence: true, length: { maximum: 100 }
  belongs_to :user
end
