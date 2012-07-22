FactoryGirl.define do
  factory :comment do
    author_name Faker::Name.name
    author_ip Faker::Internet.ip_v4_address
    comment Faker::Lorem.sentences
  end
end