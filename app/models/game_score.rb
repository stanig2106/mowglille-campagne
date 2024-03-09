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
    seen_you = false
    res = GameScore.select("game_scores.*,
                  rank() over (order by score #{inverse_score?(game_name) ? "asc" : "desc"}) as r")
                   .where(game_name:, pb: true)
                   .joins(:user)
                   .order(score: inverse_score?(game_name) ? :asc : :desc).limit(20)
                   .map do |game_score|
      seen_you = true if current_user&.id == game_score.user.id && !seen_you
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

    if (!seen_you && current_user)
      s = GameScore.select("game_scores.* as r")
                   .where(game_name:, pb: true, user: current_user)
                   .joins(:user).limit(1)
                   .first

      res << {
        id: s.id,
        you: true,
        name: s.user.name,
        score: float_score?(game_name) ? s.score.to_f : s.score.to_i,
        date: s.created_at.iso8601,
        rank: 0,
        pp: s.user.profile_picture.attached? ? s.user.profile_picture : nil,
        tries: s.tries,
        average: s.average,
        congratulated: false
      } if s
    end
    res
  end

  def tries_and_average
    result = GameScore.where(user: user, game_name: game_name)
                      .select('COUNT(score) AS count', 'AVG(score) AS average_score')[0]

    count = result.count
    average = result.average_score.round(2)

    [count, average]
  end

  def congratulated_by?(user)
    return false if user.nil?

    Congratulation.where(reason: game_name, user:, target: self.user).exists?
  end

end
