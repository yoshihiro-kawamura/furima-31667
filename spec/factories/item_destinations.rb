FactoryBot.define do
  factory :item_destination do
    postal_code     { '123-4567' }
    prefecture_id   { 1 }
    city            { '高崎市' }
    house_number    { '1-1' }
    building_name   { 'アイウエオ' }
    phone_number    { '09000000000' }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
