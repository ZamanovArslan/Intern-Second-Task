class Event < ApplicationRecord
  include PgSearch
  pg_search_scope :search_everywhere, against: %i[name_of_event date_event]

  validates :name_of_event, presence: true
  validates :regularity, presence: true
  validates :date_event, presence: true

  has_one :user, dependent: :destroy
end
