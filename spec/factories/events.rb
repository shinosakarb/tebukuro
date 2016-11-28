FactoryGirl.define do

  factory :event do
    name 'Event'
    description 'Description'
    started_at 2.hours.from_now
    ended_at 4.hours.from_now
  end

  factory :event_name_blank, class: Event do
    name nil
    description 'Description'
    started_at 2.hours.from_now
    ended_at 4.hours.from_now
  end

  factory :event_description_blank, class: Event do
    name 'name'
    description nil
    started_at 2.hours.from_now
    ended_at 4.hours.from_now
  end

  factory :event_blank, class: Event do
    name nil
    description nil
    started_at nil
    ended_at nil
  end

  factory :early_event, class: Event do
    name 'Event'
    description 'Description'
    started_at 2.hours.ago
    ended_at 4.hours.from_now
  end

  factory :start_after_end_event, class: Event do
    name 'Event'
    description 'Description'
    started_at 5.hours.from_now
    ended_at 4.hours.from_now
  end

end
