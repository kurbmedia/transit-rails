FactoryBot.define do
  factory :page, class: "Transit::Page" do
    sequence :name do |n|
      "Test Page #{n}"
    end

    sequence :title do |n|
      "Test Page Title #{n}"
    end

    sequence :slug do |n|
      "test-page-#{n}"
    end
  end
end
