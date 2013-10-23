Transit::Page.blueprint do
  name{ "Test Page #{sn}" }
  title{ "Test Page Title #{sn}"}
  slug{ "test-page-#{sn}"}
end

Transit::Page.blueprint(:regions) do
  regions(5)
end

Transit::Region.blueprint do
  content { "Sample content" }
end

Business.blueprint do
end