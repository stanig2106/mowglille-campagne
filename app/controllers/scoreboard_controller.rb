class ScoreboardController < ApplicationController
  def get_scoreboard
    render json: {
      scoreboard: User.scoreboard.map { {
        **_1, pp: _1[:pp] ? url_for(_1[:pp]) : nil
      } }
    }
  end

  def get_score_details
    # export type ScoreDetails = {
    #   event: string,
    #   score: number,
    #   hour: string,
    #   offered_by: string,
    #   title: string,
    # }[]
    render json: { score_details: current_user!.score_records.order(created_at: :desc).map { _1.instance_exec do
      {
        event: activity&.event&.type_as_s || ApplicationHelper.day_of_week_fr(created_at),
        score:, hour: created_at.strftime("%H:%M"),
        title: if activity
                 "Activité: " + activity.name
               elsif challenge
                 "Défi: " + challenge.name
               else
                 reason
               end,
        offered_by: offered_by&.first_name
      }
    end } }
  end
end
