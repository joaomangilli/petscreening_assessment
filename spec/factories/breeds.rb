FactoryBot.define do
  factory :breed do
    name { SecureRandom.hex }
    description { 'A happy dog' }
    life_min { 1 }
    life_max { 15 }
    male_weight_min { 0 }
    male_weight_max { 500 }
    female_weight_min { 0 }
    female_weight_max { 500 }
  end
end
