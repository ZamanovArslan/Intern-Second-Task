class EventDecorator < ApplicationDecorator
  delegate_all

  def regularity
    if object.regularity == "o"
      "Once"
    elsif object.regularity == "d"
      "Every day"
    elsif object.regularity == "w"
      "Every week"
    elsif object.regularity == "m"
      "Every month"
    elsif object.regularity == "y"
      "Every year"
    end
  end
end
