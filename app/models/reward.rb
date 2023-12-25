class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :activity_reward
end
