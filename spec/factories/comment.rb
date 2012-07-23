FactoryGirl.define do
  factory :comment do
    author_name Faker::Name.name
    author_email Faker::Internet.email
    author_ip Faker::Internet.ip_v4_address
    comment Faker::Lorem.sentence
  end
end