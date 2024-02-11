class Chest < ApplicationRecord
  belongs_to :user

  validates :type, inclusion: { in: %w[rare epic legendary] }

  self.inheritance_column = nil

end
