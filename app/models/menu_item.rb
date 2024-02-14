class MenuItem < ApplicationRecord
  MenuItem.inheritance_column = nil
  belongs_to :event

end
