class Review < ApplicationRecord
  belongs_to :stage
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :commented_users, through: :comments, source: :user
  validates :rate, presence: true
  validates :rate, numericality: {
      less_than_or_equal_to: 5,
      greater_than_or_equal_to: 0.5
   },
   if:  Proc.new { |a| a.rate.present? }

  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end

  def self.sort(selection)
    case selection
    when 'new'
      all.order(created_at: :DESC)
    when 'old'
      all.order(created_at: :ASC)
    when 'watched'
      all.order(date: :DESC)
    when 'watched_a'
      all.order(date: :ASC)
    when 'rate'
      all.order(rate: :DESC)
    when 'favorites'
      all.sort { |a, b| b.favorited_users.size <=> a.favorited_users.size }
    when 'comments'
      all.sort { |a, b| b.commented_users.size <=> a.commented_users.size }
    end
  end
end
