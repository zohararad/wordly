FactoryGirl.define do
  factory :post do
    title Faker::Lorem.sentence(6)
    content Faker::Lorem.paragraph
    author_id { [1,2,3,4,5].select }
  end
end