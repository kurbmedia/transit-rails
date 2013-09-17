Transit::Page.blueprint do
  name{ "Test Page #{sn}" }
  title{ "Test Page Title #{sn}"}
  slug{ "test-page-#{sn}"}
end

Transit::Region.blueprint do
end

Business.blueprint do
end