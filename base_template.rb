run "echo TODO > README"

gem 'RedCloth', :lib => 'redcloth'
gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'

if yes?("Do you want to use HAML?")
	gem 'haml'
	run "haml --rails ."
end
rake "gems:install"

plugin "rspec", :git => "git://github.com/dchelimsky/rspec.git"
plugin "rspec-rails", :git => "git://github.com/dchelimsky/rspec-rails.git"
generate :rspec

generate :cucumber
run "rm public/index.html"

git :init
file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

rake "db:create:all"

git :add  => "." 
git :commit => "-a -m 'initial commit'"