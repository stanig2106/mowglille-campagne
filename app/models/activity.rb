class Activity < ApplicationRecord
  belongs_to :event
  has_many :activity_rewards, dependent: :destroy
  has_many :score_records, dependent: :restrict_with_error
end
