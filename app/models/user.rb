class User < ApplicationRecord

  has_many :score_records

  def score
    score_records.sum(:score)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def rank
    return 0 if score == 0
    User.select('users.*, rank() over (order by sum_score desc) as rank')
        .joins('LEFT JOIN (SELECT user_id, SUM(score) as sum_score FROM score_records GROUP BY user_id) scores ON scores.user_id = users.id')
        .where('users.id = ?', self.id)
        .first
        .rank
  end

  def self.scoreboard
    User.select('users.*, sum(score_records.score) as total_score, rank() over (order by sum(score_records.score) desc) as rank')
        .joins('LEFT JOIN score_records ON score_records.user_id = users.id')
        .group('users.id')
        .having('sum(score_records.score) > 0')
        .map do |user|
      {
        rank: user.rank,
        name: user.name,
        score: user.total_score
      }
    end
  end

  def qr_code_content
  end

end
