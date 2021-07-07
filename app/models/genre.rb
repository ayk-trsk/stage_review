class Genre < ApplicationRecord
  has_many :stages
  validates :name, presence: true, uniqueness: true
end
