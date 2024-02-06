class ScoreRecord < ApplicationRecord
  belongs_to :user
  belongs_to :challenge, optional: true
  belongs_to :activity, optional: true
  belongs_to :offered_by, class_name: "User", optional: true
end
