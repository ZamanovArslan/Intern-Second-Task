class Event < ApplicationRecord
  validates :name_of_event, presence: true
  validates :regularity, presence: true
  validates :date_event, presence: true

  def self.is_available(date, id)
    # LANGUAGE = SQL
    find_by_sql("SELECT *
                FROM events
                WHERE user_id = #{id} AND (\"events\".\"date_event\" = '#{date}'::date
                   OR '#{date}'::date > date_event AND
                      (regularity = 'd' OR
                       regularity = 'w' AND date_part('DAY', age(date_event, '#{date}'::date))::INTEGER % 7 = 0 OR
                       regularity = 'm' AND Extract(DAY FROM date_event) = #{date.day} OR
                       regularity = 'y' AND Extract(DAY FROM date_event) = #{date.day} AND
                       Extract(MONTH FROM date_event) = #{date.month}));")
  end

  def self.search(query, id)
    Event.where('name_of_event LIKE ? AND user_id = ?', "%#{query}%", id)
  end
end
