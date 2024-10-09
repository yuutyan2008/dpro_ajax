class Favorite < ApplicationRecord
  belongs_to :blog
  belongs_to :user

  validates :blog, presence: true
end
