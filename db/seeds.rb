require 'faker'

5.times do
  community = Community.create!(
  name: Faker::Company.name,
  description: Faker::Company.catch_phrase
  )
  10.times do
    instrument = Faker::Music.instrument
    name = "#{instrument} practice"
    description = "Let's practice the #{instrument} together"

    community.events.create!(
      name:  name,
      description: description,
      )
  end
  community
end
