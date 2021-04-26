FactoryBot.define do
  factory :comment do
    dance_id { 1 }
    music_id { 1 }
    stage_id { 1 }
    content { "MyText" }
  end
end
