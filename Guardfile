# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', {
  cli:            '--colour --format documentation --fail-fast',
  version:        2,
  all_after_pass: false,
  all_on_start:   false,
  notify:         true } do
  
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
  
  watch(%r{^lib/transit/models/(.+)\.rb$}){ |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/models/transit/(.+)\.rb$})            { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/transit/helpers/(.+)\.rb$})           { |m| "spec/helpers/#{m[1]}_spec.rb" }
  watch(%r{^lib/transit/(.+)\.rb$})                           { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  
end

