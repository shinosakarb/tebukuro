require 'faker'

10.times do |n|
  instrument = Faker::Music.instrument
  name = instrument + ' practice'
  description = "Let's practice the #{instrument} together"
  community_id = n + 1

  event = Event.create!(
    name:  name,
    description: description,
    community_id: community_id
    )
end
