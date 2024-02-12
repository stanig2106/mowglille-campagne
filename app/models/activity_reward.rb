class ActivityReward < ApplicationRecord
  belongs_to :activity
  has_many :rewards, dependent: :destroy
end
