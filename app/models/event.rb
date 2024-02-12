class Event < ApplicationRecord
  Event.inheritance_column = nil
  has_many :activities, dependent: :destroy
end
