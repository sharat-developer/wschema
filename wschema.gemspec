Gem::Specification.new do |s|
  s.name               = 'wschema'
  s.version            = '0.0.2'
  s.default_executable = 'wschema'
  s.add_runtime_dependency 'json', '~> 2.3', '>= 2.3.0'
  s.add_development_dependency 'json', '~> 2.3', '>= 2.3.0'

  if s.respond_to? :required_rubygems_version=
    s.required_rubygems_version =
      Gem::Requirement.new('>= 0')
  end
  s.authors = ['Sharat Hegde']
  s.date = '2020-09-26'
  s.description = 'Workato schema gem. Formats Workato schema to remove the defaults and sanitize the object_definition fields.'
  s.email = 'sharat.developer@gmail.com'
  s.files =
    ['Rakefile', 'lib/wschema.rb', 'bin/wschema']
  s.test_files = ['test/test_wschema.rb']
  s.homepage = 'http://rubygems.org/gems/wschema'
  s.require_paths = ['lib']
  s.rubygems_version = '1.6.2'
  s.summary = 'Wschema!'

  if s.respond_to? :specification_version
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
    end
  end
end
