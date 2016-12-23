FactoryGirl.define do

  factory :community do
    name 'Community'
    description 'Description'
  end

  factory :community_name_blank do
    name nil
    description 'Description'
  end

  factory :community_description_blank do
    name 'name'
    description nil
  end

  factory :community_blank do
    name nil
    description nil
  end
  
end
