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

  def open
    chest = current_user!.chests.find(params[:id])


  end

  private
  def chest_reward
    [
      # coffre cadeau
      ["R"],

      # dej 1
      ["R"],

      # pdej 1

      # soirée à lille

      # dej 2
      ["R"],

      # fin d'aprèm
      ["E", "R"],
      ["R"],
      ["R"],
      ["L", "E", "R"],

      # pdej 2 [1, 2, 7]
      ["L", "E", "R"],

      # Brunch
      ["E", "R"],

      # Aprèm
      ["E", "R"],
      ["R"],
      ["E", "R"],
      ["E", "R"],
      ["R"],
      ["E", "R"],
      ["L", "E", "R"],
      ["L", "E", "R"],
      ["L", "E", "R"],
      ["L", "E", "R"],
      ["L", "E", "R"],
   ]

  end
end
