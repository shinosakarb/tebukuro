require 'faker'
require 'date'

FactoryGirl.define do

  # 例) Sat, 10 Feb 2007 15:30:45 EST -05:00
  # 必ずこの形式でないと、JSON.parse()で日付のフォーマットがISO8061に変換されなくなる。
  factory_time = Time.zone.local(2015,12,15)

  trait :partial_ticket_detail_information do
    sale_starts_at factory_time
    sale_ends_at factory_time
  end

  factory :ticket do
    name {generate :name}
    cost {generate :cost}
    quantity {generate :quantity}
    partial_ticket_detail_information
    purchased true
  end

end
