# frozen_string_literal: true

require 'faker'
require 'date'

FactoryBot.define do
  # 例) Sat, 10 Feb 2007 15:30:45 EST -05:00
  # 必ずこの形式でないと、JSON.parse()で日付のフォーマットがISO8061に変換されなくなる。
  factory_time = Time.zone.local(2015, 12, 15)

  trait :partial_event_detail_information do
    event_starts_at factory_time
    event_ends_at factory_time
  end

  factory :event do
    sequence(:name) { |n| "イベント #{n}" }
    description { generate :description }
    quota Faker::Number.between(1, 1000)
  end
end
