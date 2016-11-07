FactoryGirl.define do

  factory :event do
    name 'Event'
    description 'Description'
  end

  factory :event_name_blank, class: Event do
    name nil
    description 'Description'
  end

  factory :event_description_blank, class: Event do
    name 'name'
    description nil
  end

  factory :event_blank, class: Event do
    name nil
    description nil
  end

end
