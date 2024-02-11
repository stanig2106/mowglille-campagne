class Activity < ApplicationRecord
  belongs_to :event
  has_many :activity_rewards
end
