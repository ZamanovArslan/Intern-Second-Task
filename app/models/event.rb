class Event < ApplicationRecord
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
end
