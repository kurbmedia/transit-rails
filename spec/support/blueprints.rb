Page.blueprint do
  name{ "Test Page #{sn}" }
  title{ "Test Page Title #{sn}"}
  slug{ "test-page-#{sn}"}
end

Post.blueprint do
  title { "Sample Post Number #{sn}" }
  post_date{ Date.today }
end