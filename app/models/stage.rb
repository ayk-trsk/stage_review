class Stage < ApplicationRecord
  belongs_to :genre
  validates :name, presence: true, uniqueness: true
  validates :genre, :start_date,  presence: true
end
