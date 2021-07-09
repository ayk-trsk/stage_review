class Stage < ApplicationRecord
  belongs_to :genre
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :genre, :start_date,  presence: true
end
