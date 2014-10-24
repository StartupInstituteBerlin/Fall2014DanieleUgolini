FactoryGirl.define do
	factory :restaurant do
    name "Just a name"
    description "Here a description"
    full_address "Some street, some City, State"
    phone_number "123456789"
    owner
  end
end
