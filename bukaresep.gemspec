# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bukaresep/version'

Gem::Specification.new do |spec|
  spec.name           = 'bukaresep'
  spec.version        = Bukaresep::VERSION
  spec.summary        = 'a simple gem CRUD for managing food recipe'
  spec.description    = 'bukaresep is a simple gem for managing food recipe'
  spec.homepage       = 'https://github.com/imamfzn/bukaresep-ruby'
  spec.authors        = ['Muhammad Imam Fauzan']
  spec.email          = ['imam.fauzan@bukalapak.com']
  spec.license        = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.metadata['allowed_push_host'] = 'http://mygemserver.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject{ |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir         = 'exe'
  spec.executables    = spec.files.grep(%r{^exe/}){ |f| File.basename(f) }
  spec.require_paths  = ['lib']

  spec.add_runtime_dependency 'dotenv', '~>2.5.0', '>= 2.0.0'
  spec.add_runtime_dependency 'rake', '~>12.3.1', ' >= 12.3.0'
  spec.add_runtime_dependency 'sqlite3', '~>1.3.13', '>= 1.3.0'
end
