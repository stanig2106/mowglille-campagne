class User < ApplicationRecord

  has_many :game_scores, dependent: :destroy
  has_many :score_records, dependent: :destroy
  has_many :qr_codes, dependent: :destroy
  belongs_to :cla_info, dependent: :destroy

  STAFF_ROLES = {
    SEE_PLANNING: "See planning",
    MANAGE_PLANNING: "Manage planning",

    NEW_STAFF: "Create new staff",

    CUSTOM_SCORE: "Add custom score",
    SCORE: "Add legal score",
    MANAGE_SCORE: "Manage legals score of activities",

    CHALLENGE_MANAGE: "Manage challenge",
    CHALLENGE_VALIDATION: "Validate challenge",

    MANAGE_SOUND: "Manage sound",

    MANAGE_CHAT: "Manage chat",

    MANAGE_PHOTO: "Manage photo",
  }
  validate :staff_roles_are_valid

  def staff_roles_are_valid
    staff_roles.each do |role|
      errors.add(:staff_roles, "Invalid role: #{role}") \
        unless STAFF_ROLES.keys.include?(role.to_sym)
    end
  end



  def has_staff_role?(role)
    staff_roles.include?(role.to_s)
  end

  scope :staffers, -> { where.not(staff_roles: []) }

  delegate :first_name, :last_name, :school_email, :cursus, :promo, to: :cla_info

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
