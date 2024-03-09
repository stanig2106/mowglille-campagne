class CreateChallengeValidation < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_validations do |t|
      t.references :challenge, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
