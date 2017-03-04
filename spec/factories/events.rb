require 'faker'
require 'date'

FactoryGirl.define do

  # 例) Sat, 10 Feb 2007 15:30:45 EST -05:00
  # 必ずこの形式でないと、JSON.parse()で日付のフォーマットがISO8061に変換されなくなる。
  factory_time = Time.zone.local(2015,12,15)

  trait :partial_event_detail_information do
    event_starts_at factory_time
    event_ends_at factory_time
  end

  factory :event do
    name {generate :name}
    description {generate :description}
    address { ForgeryJa(:address).full_address }
    partial_event_detail_information
  end

  factory :event_name_blank, class: Event do
    name nil
    description {generate :description}
    address { ForgeryJa(:address).full_address }
    partial_event_detail_information
  end

  factory :event_description_blank, class: Event do
    name {generate :name}
    description nil
    address { ForgeryJa(:address).full_address }
    partial_event_detail_information
  end

  factory :event_address_blank, class: Event do
    name {generate :name}
    description {generate :description}
    address nil
    partial_event_detail_information
  end

  factory :event_blank, class: Event do
    name nil
    description nil
    address nil
    partial_event_detail_information
  end

end
