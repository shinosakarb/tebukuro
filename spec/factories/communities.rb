FactoryGirl.define do

  factory :community, class: Community do
    name 'Community'
    description 'Description'
  end

  factory :community_name_blank, class: Community do
    name nil
    description 'Description'
  end

  factory :community_description_blank, class: Community do
    name 'name'
    description nil
  end

  factory :community_blank, class: Community do
    name nil
    description nil
  end
  
end
