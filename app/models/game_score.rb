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

end
