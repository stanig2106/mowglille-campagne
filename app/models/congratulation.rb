class Congratulation < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :target, class_name: "User", dependent: :destroy
end
