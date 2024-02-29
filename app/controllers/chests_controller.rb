class ChestsController < ApplicationController

  def index
    render json: {
      chests: current_user!.chests.map do |c|
        {
          id: c.id,
          rarity: c.type,
        }
      end
    }
  end

end
