class Review < ApplicationRecord
  belongs_to :stage
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :commented_users, through: :comments, source: :user
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'watched'
      return all.order(date: :DESC)
    when 'watched_a'
      return all.order(date: :ASC)
    when 'rate'
      return all.order(rate: :DESC)
    when 'favorites'
      return all.sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    when 'comments'
      return all.sort {|a,b| b.commented_users.size <=> a.commented_users.size}
    end
  end
end
