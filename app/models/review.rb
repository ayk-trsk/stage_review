class Review < ApplicationRecord
  belongs_to :stage
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end
end
