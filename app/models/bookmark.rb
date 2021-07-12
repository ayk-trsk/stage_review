class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :stage

  validates_uniqueness_of :stage_id, scope: :user_id
end
