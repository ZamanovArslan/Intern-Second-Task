FactoryBot.define do
  factory :event do
    name_of_event { FFaker::Book.title }
    regularity { %w[o w m y].sample }
    date_event { FFaker::Time.date }
  end
end
