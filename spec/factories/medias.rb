FactoryBot.define do
  factory :media, class: "Transit::Media" do
    sequence :name do |n|
      "Media #{n}"
    end
  end
end
