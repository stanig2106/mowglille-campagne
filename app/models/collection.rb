class Collection < ApplicationRecord
  belongs_to :user
  belongs_to :collection_piece
end
