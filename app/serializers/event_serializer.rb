class EventSerializer < ActiveModel::Serializer
  attributes :id, :name_of_event, :regularity, :date_event, :start_of_event, :end_of_event

  def start_of_event
    object.start_of_event&.strftime("%H:%M")
  end

  def end_of_event
    object.end_of_event&.strftime("%H:%M")
  end
end
