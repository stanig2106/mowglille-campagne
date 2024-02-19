class GameScore < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates_inclusion_of :game_name, in: %w[
    human_benchmark_reaction_time
    human_benchmark_chimp_test
    human_benchmark_sequence_memory
    human_benchmark_aim_trainer
    human_benchmark_number_memory
    human_benchmark_verbal_memory
    human_benchmark_visual_memory
  ]

  def self.inverse_score?(game)
    game.in? %w[
      human_benchmark_reaction_time
      human_benchmark_aim_trainer
    ]
  end

  def self.float_score?(game)
    game.in? %w[
      human_benchmark_reaction_time
      human_benchmark_aim_trainer
    ]
  end

  def self.get_scoreboard(game_name, current_user = nil)
    GameScore.select("game_scores.*, rank() over (order by score #{inverse_score?(game_name) ? "asc" : "desc"}) as r")
             .where(game_name:, pb: true)
             .joins(:user)
             .order(score: inverse_score?(game_name) ? :asc : :desc)
             .map do |game_score|
      {
        id: game_score.id,
        you: current_user&.id == game_score.user.id,
        name: game_score.user.name,
        score: float_score?(game_name) ? game_score.score.to_f : game_score.score.to_i,
        date: game_score.created_at.iso8601,
        rank: game_score.r,
        pp: game_score.user.profile_picture.attached? ? game_score.user.profile_picture : nil,
        tries: game_score.tries,
        average: game_score.average,
        congratulated: game_score.congratulated_by?(current_user)
      }
    end
  end

  def tries
    GameScore.where(user:, game_name:).count
  end

  def average
    GameScore.where(user:, game_name:).average(:score).round(2)
  end

  def congratulated_by?(user)
    return false if user.nil?

    Congratulation.where(reason: game_name, user:, target: self.user).exists?
  end

end
