require 'faker'

FactoryBot.define do

  sequence(:name) {Faker::Name.name}
  sequence(:description) {Faker::Lorem.paragraph}
  sequence(:cost) {Faker::Number.number(3).to_i}
  sequence(:quantity) {Faker::Number.number(2).to_i}
  # sequence(:event_starts_at) { Faker::Time.forward(14, :morning)}
  # sequence(:event_ends_at) { Faker::Time.forward(21, :morning)}

end
