class Event < ApplicationRecord
  validates :name_of_event, presence: true
  validates :regularity, presence: true
  validates :date_event, presence: true

  has_one :user, dependent: :destroy
end
