FactoryBot.define do
  factory :item do
    name                  { 'タイトル' }
    example               { '面白い絵画' }
    category_id           { 2 }
    item_condition_id     { 2 }
    shipping_charge_id    { 2 }
    area_id               { 2 }
    day_id                { 2 }
    price                 { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
