class ChestsController < ApplicationController

  def index
    winner = if current_user!.collection_winner
               true
             elsif (w = User.where(collection_winner: true).first)
               w.name
             else
               false
             end

    render json: {
      chests: current_user!.chests.map do |c|
        {
          id: c.id,
          rarity: c.type
        }
      end,
      rewards: current_user!.piece_order,
      collections: current_user!.collection_pieces.pluck(:number),
      winner:
    }
  end

  def open
    chest = current_user!.chests.find(params[:id])

    #   const res = [] as ChestRewards
    #   if (!opening.value || !chestsStore.rewards)
    #     return res;
    #
    #   const rarity = ["rare", "epic", "legendary"] as const
    #   rarity.forEach((r) => {
    #     if (rarity.indexOf((opening.value as Chests[number]).rarity) >= rarity.indexOf(r))
    #       if (chestsStore.rewards![r].length > 0)
    #         res.push({
    #           type: "piece", rarity: r,
    #           id: chestsStore.rewards![r].shift()!
    #         })
    #       else
    #         res.push({
    #           type: "score",
    #           amount: rarity.indexOf(r) * 100 + 100
    #         })
    #   })
    #
    #   return res

    rarity = %w[rare epic legendary]
    rarity.each do |r|
      if rarity.index(chest.type) >= rarity.index(r)
        if current_user!.piece_order[r.to_sym].length > 0
          current_user!.collection_pieces << CollectionPiece.find_by(
            number: current_user!.piece_order[r.to_sym].shift
          )
        else
          current_user!.score_records.create(
            reason: "Récompense de coffre",
            score: rarity.index(r) * 100 + 100
          )
        end
      end
    end

    chest.destroy
    current_user!.save

    current_user!.update(collection_winner: true) if current_user!.collection_pieces.count == CollectionPiece.count &&
      User.where(collection_winner: true).count == 0

    current_user!.score_records.create(
      reason: "Collection complété !",
      score: 500
    ) if current_user!.collection_pieces.count == CollectionPiece.count &&
      User.where(collection_winner: true).count >= 1

    render json: { success: true }
  end
end
