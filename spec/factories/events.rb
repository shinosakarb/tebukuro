require 'faker'
require 'date'

FactoryGirl.define do

<<<<<<< HEAD
<<<<<<< HEAD
  # 例) Sat, 10 Feb 2007 15:30:45 EST -05:00
  # 必ずこの形式でないと、JSON.parse()で日付のフォーマットがISO8061に変換されなくなる。
  factory_time = Time.zone.local(2015,12,15)

  trait :event_detail_information do
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
    event_detail_information
=======
  # 例) Mon, 05 Dec 2016 23:05:06 UTC +00:00
  # def factory_time(time)
  #   if time.kind_of?(String)
  #     Time.strptime(time, '%Y-%m-%dT%H:%M:%S%z').utc.to_s
  #   else
  #     ArgumentError
  #   end
  # end

=======
>>>>>>> 1c72a1e... FIX add event_detail_information
  # 例) Sat, 10 Feb 2007 15:30:45 EST -05:00
  # 必ずこの形式でないと、JSON.parse()で日付のフォーマットがISO8061に変換されなくなる。
  factory_time = Time.zone.local(2015,12,15)

  trait :event_detail_information do
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
<<<<<<< HEAD
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> e9aec92... ADD event_detail_information
=======
    event_detail_information
>>>>>>> 1c72a1e... FIX add event_detail_information
  end

  factory :event_name_blank, class: Event do
    name nil
    description {generate :description}
<<<<<<< HEAD
<<<<<<< HEAD
    event_detail_information
=======
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> e9aec92... ADD event_detail_information
=======
    event_detail_information
>>>>>>> 1c72a1e... FIX add event_detail_information
  end

  factory :event_description_blank, class: Event do
    name {generate :name}
    description nil
<<<<<<< HEAD
<<<<<<< HEAD
    event_detail_information
=======
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> e9aec92... ADD event_detail_information
=======
    event_detail_information
>>>>>>> 1c72a1e... FIX add event_detail_information
  end

  factory :event_blank, class: Event do
    name nil
    description nil
<<<<<<< HEAD
<<<<<<< HEAD
    event_detail_information
=======
    invitation_starts_at factory_time
    invitation_ends_at factory_time
    event_starts_at factory_time
    event_ends_at factory_time
    number_of_accepted_participants {generate :number_of_accepted_participants}
    cost {generate :cost}
>>>>>>> e9aec92... ADD event_detail_information
=======
    event_detail_information
>>>>>>> 1c72a1e... FIX add event_detail_information
  end

end
