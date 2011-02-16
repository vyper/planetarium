require 'rake/testtask'

lib_dir = File.expand_path('lib')
test_dir = File.expand_path('test')

task "default" => ["test"]

Rake::TestTask.new("test") do |t|
  t.libs = [lib_dir, test_dir]
  t.pattern = "test/**/test_*.rb"
  t.warning = true
  t.verbose = true
end
