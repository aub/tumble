Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=

  s.name    = 'tumbler'
  s.version = '0.0.2'

  s.summary     = 'Library for accessing the Tumblr api v2'
  # TODO: s.description

  s.authors  = ['Aubrey Holland']
  s.email    = 'aubreyholland@gmail.com'
  s.homepage = 'https://github.com/aub/tumble'

  s.add_dependency 'faraday'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'

  # = MANIFEST =
  s.files = %w[
    Gemfile
    README.md
    Rakefile
    lib/tumblr2.rb
    lib/tumblr2/blog.rb
    lib/tumblr2/client.rb
    spec/blog_spec.rb
    spec/client_spec.rb
    spec/spec_helper.rb
    tumblr2.gemspec
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ %r{^test/*/.+\.rb} }
end
