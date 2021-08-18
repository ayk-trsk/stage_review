class Stage < ApplicationRecord
  belongs_to :genre
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :genre, :start_date, :end_date, presence: true
  validate :end_date_check

  def end_date_check
    errors.add(:end_date, "は公演開始日と同じ日または遅い日を選択してください") if start_date.present? && end_date.present? && self.start_date > self.end_date
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  def stage_id_and_name
    self.id.to_s + '. ' + self.name
  end
end
