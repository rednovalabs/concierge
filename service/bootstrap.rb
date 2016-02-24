this_file      = __FILE__
models_to_load = Dir[File.dirname(__FILE__) + '/*.rb'] - [this_file]

models_to_load.each do |service|
  require service
end
