class Result < ApplicationRecord
  belongs_to :user
  belongs_to :venue
  belongs_to :court
end
