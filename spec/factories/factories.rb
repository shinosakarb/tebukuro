require 'faker'

FactoryGirl.define do

  sequence(:name) {Faker::Name.name}
  sequence(:description) {Faker::Lorem.paragraph}
  # sequence(:invitation_starts_at) { Faker::Time.forward(1, :morning)}
  # sequence(:invitation_ends_at) { Faker::Time.forward(8, :morning)}
  # sequence(:event_starts_at) { Faker::Time.forward(14, :morning)}
  # sequence(:event_ends_at) { Faker::Time.forward(21, :morning)}
<<<<<<< HEAD
  sequence(:number_of_accepted_participants) { Faker::Number.between(1, 200)}
  sequence(:cost) { Faker::Number.between(1,10000)}
=======
>>>>>>> tmp

end
