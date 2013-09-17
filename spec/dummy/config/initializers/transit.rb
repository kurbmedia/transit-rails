Transit.setup do |conf|
  require "transit/adapters/#{TRANSIT_ORM}"  
end