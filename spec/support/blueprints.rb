Transit::Page.blueprint do
  name{ "Test Page #{sn}" }
  title{ "Test Page Title #{sn}"}
  slug{ "test-page-#{sn}"}
end

Transit::Page.blueprint(:regions) do
  regions(5)
end

Transit::Page.blueprint(:region) do
  regions(1)
end

Transit::MediaFolder.blueprint do
  name { "Folder #{sn}" }
end

Transit::Media.blueprint do
  name { "Media #{sn}" }
end

# 
# Transit::Region.blueprint do
#   content { "Sample content" }
# end

Business.blueprint do
end