FactoryGirl.define do

  factory :event do
    name 'Event'
    description 'Description'
    start_time 2.hours.from_now
    end_time 4.hours.from_now
  end

  factory :event_name_blank, class: Event do
    name nil
    description 'Description'
    start_time 2.hours.from_now
    end_time 4.hours.from_now
  end

  factory :event_description_blank, class: Event do
    name 'name'
    description nil
    start_time 2.hours.from_now
    end_time 4.hours.from_now
  end

  factory :event_blank, class: Event do
    name nil
    description nil
    start_time nil
    end_time nil
  end

  factory :early_event, class: Event do
    name 'Event'
    description 'Description'
    start_time 2.hours.ago
    end_time 4.hours.from_now
  end

  factory :start_after_end_event, class: Event do
    name 'Event'
    description 'Description'
    start_time 5.hours.from_now
    end_time 4.hours.from_now
  end

end
