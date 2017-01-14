require 'faker'

FactoryGirl.define do

  sequence(:name) {Faker::Name.name}
  sequence(:description) {Faker::Lorem.paragraph}
  # sequence(:event_starts_at) { Faker::Time.forward(14, :morning)}
  # sequence(:event_ends_at) { Faker::Time.forward(21, :morning)}

end
