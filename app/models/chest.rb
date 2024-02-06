class Chest < ApplicationRecord
  belongs_to :user

  validates :type, inclusion: { in: types }

  def self.types
    ["rare", "epic", "legendary"]
  end
end
