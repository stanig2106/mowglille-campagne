class Chest < ApplicationRecord
  belongs_to :user

  validates :type, inclusion: { in: %w[rare epic legendary] }

end
