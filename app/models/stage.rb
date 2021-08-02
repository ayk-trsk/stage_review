class Stage < ApplicationRecord
  belongs_to :genre
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :genre, :start_date, :end_date, presence: true

  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  def stage_id_and_name
    self.id.to_s + '. ' + self.name
  end
end
