require 'faker'
require 'date'

FactoryGirl.define do

<<<<<<< 32ff1bed124921c00ada3b6a7072a9e9e4115635
  # 例) Sat, 10 Feb 2007 15:30:45 EST -05:00
  # 必ずこの形式でないと、JSON.parse()で日付のフォーマットがISO8061に変換されなくなる。
  factory_time = Time.zone.local(2015,12,15)

  trait :partial_event_detail_information do
      invitation_starts_at factory_time
      invitation_ends_at factory_time
      event_starts_at factory_time
      event_ends_at factory_time
      number_of_accepted_participants {generate :number_of_accepted_participants}
      cost {generate :cost}
  end

  factory :event do
    name {generate :name}
    description {generate :description}
    partial_event_detail_information
=======
  # 例) Mon, 05 Dec 2016 23:05:06 UTC +00:00
  # def factory_time(time)
  #   if time.kind_of?(String)
  #     Time.strptime(time, '%Y-%m-%dT%H:%M:%S%z').utc.to_s
  #   else
  #     ArgumentError
  #   end
  # end

  # 例) Sat, 10 Feb 2007 15:30:45 EST -05:00
  # 必ずこの形式でないと、JSON.parse()で日付のフォーマットがISO8061に変換されなくなる。
  factory_time = Time.utc(2007, 2, 10, 20, 30, 45).in_time_zone

  #costは単位は¥
  factory :event do
    name {generate :name}
    description {generate :description}
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> ADD event_detail_information
  end

  factory :event_name_blank, class: Event do
    name nil
    description {generate :description}
<<<<<<< 32ff1bed124921c00ada3b6a7072a9e9e4115635
    partial_event_detail_information
=======
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> ADD event_detail_information
  end

  factory :event_description_blank, class: Event do
    name {generate :name}
    description nil
<<<<<<< 32ff1bed124921c00ada3b6a7072a9e9e4115635
    partial_event_detail_information
=======
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> ADD event_detail_information
  end

  factory :event_blank, class: Event do
    name nil
    description nil
<<<<<<< 32ff1bed124921c00ada3b6a7072a9e9e4115635
    partial_event_detail_information
=======
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> ADD event_detail_information
  end

end
