FactoryGirl.define do

  factory :community do
    sequence(:id) { |n| n }
    name 'Community name'
    description 'Community description'
    after(:build) do |community|
      community.events << build(:event, community: community)
    end
  end

  factory :community_name_blank, class: Community do
    name nil
    description 'Community description'
  end

  factory :community_description_blank, class: Community do
    name 'Community name'
    description nil
  end

  factory :community_blank, class: Community do
    name nil
    description nil
  end

  end
