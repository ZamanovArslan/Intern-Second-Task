class UserDecorator < Draper::Decorator
  delegate_all

  def available_events(date_event)
    date = Date.parse(date_event)
    # Если событие повторяется единожды, то нужно только чтобы переданная дата и дата события были равны, иначе
    # Если каждую неделю, то количество дней между переданной датой и событием должно быть кратно 7,
    # Если каждый месяц, то дни месяца переданной даты и события должны совпадать,
    # Если каждый год, то день месяца и сам месяц должен совпадать
    events.where("date_event = :date
                   OR :date > date_event AND
                      (regularity = 'd' OR
                       regularity = 'w' AND date_part('DAY', age(date_event, :date))::INTEGER % 7 = 0 OR
                       regularity = 'm' AND Extract(DAY FROM date_event) = :date_day OR
                       regularity = 'y' AND Extract(DAY FROM date_event) = :date_day AND
                       Extract(MONTH FROM date_event) = :date_month)", date: date, date_day: date.day, date_month: date.month)
  end

  def search(query)
    events.search_everywhere(query)
  end

  def events_by_params(params)
    if params[:q]
      search(params[:q])
    elsif params[:date_event]
      available_events(params[:date_event])
    end
  end
end
