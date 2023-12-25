class ScoreRecord < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :challenge
  belongs_to :activity
end
