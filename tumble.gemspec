Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=

  s.name    = 'tumble'
  s.version = '0.0.5'

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
    lib/tumble.rb
    lib/tumble/blog.rb
    lib/tumble/client.rb
    lib/tumble/config.rb
    lib/tumble/connection.rb
    lib/tumble/request/oauth.rb
    spec/blog_spec.rb
    spec/client_spec.rb
    spec/config_spec.rb
    spec/connection_spec.rb
    spec/oauth_spec.rb
    spec/spec_helper.rb
    tumble.gemspec
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ %r{^test/*/.+\.rb} }
end
