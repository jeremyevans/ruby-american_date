require "rake"
require "rake/clean"

CLEAN.include ["*.gem", "rdoc"]
RDOC_OPTS = ['--inline-source', '--line-numbers', '--title', '', '--main', 'README.rdoc']

rdoc_task_class = begin
  require "rdoc/task"
  RDOC_OPTS.concat(['-f', 'hanna'])
  RDoc::Task
rescue LoadError
  require "rake/rdoctask"
  Rake::RDocTask
end

rdoc_task_class.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.options += RDOC_OPTS
  rdoc.rdoc_files.add %w"lib/american_date.rb MIT-LICENSE CHANGELOG README.rdoc"
end

begin
  require "spec/rake/spectask"
  spec_class = Spec::Rake::SpecTask
  spec_files_meth = :spec_files=
rescue LoadError
  # RSpec 2
  require "rspec/core/rake_task"
  spec_class = RSpec::Core::RakeTask
  spec_files_meth = :pattern=
end

desc "Run specs"
spec_class.new("spec") do |t|
  t.send(spec_files_meth, ["spec/american_date_spec.rb"])
end
task :default=>[:spec]

desc "Package american_date"
task :gem=>[:clean] do
  load './american_date.gemspec'
  Gem::Builder.new(AMERICAN_DATE_GEMSPEC).build
end
