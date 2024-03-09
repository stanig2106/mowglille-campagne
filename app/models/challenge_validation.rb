class ChallengeValidation < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
end
