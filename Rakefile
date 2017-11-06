require "rake"
require "rake/clean"

CLEAN.include ["*.gem", "rdoc"]
RDOC_OPTS = ['--inline-source', '--line-numbers', '--title', '', '--main', 'README.rdoc']

rdoc_task_class = begin
  require "rdoc/task"
  RDOC_OPTS.concat(['-f', 'hanna'])
  RDoc::Task
rescue LoadError
  begin
    require "rake/rdoctask"
    Rake::RDocTask
  rescue RuntimeError
  end
end

if rdoc_task_class
  rdoc_task_class.new do |rdoc|
    rdoc.rdoc_dir = "rdoc"
    rdoc.options += RDOC_OPTS
    rdoc.rdoc_files.add %w"lib/american_date.rb MIT-LICENSE CHANGELOG README.rdoc"
  end
end

desc "Run specs"
task :spec do
  sh "#{FileUtils::RUBY} -I lib spec/american_date_spec.rb"
end
task :default=>[:spec]

desc "Package american_date"
task :gem=>[:clean] do
  load './american_date.gemspec'
  Gem::Builder.new(AMERICAN_DATE_GEMSPEC).build
end
