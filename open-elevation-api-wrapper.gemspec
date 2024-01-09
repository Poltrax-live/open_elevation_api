# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'open-elevation-api-wrapper'
  s.version     = '0.1.0'
  s.summary     = 'Handles selecting elevation from Open Elevation API'
  s.description = 'Works for both official API and self-hosted versions'
  s.authors     = ['Stanislaw Zawadzki']
  s.email       = 'st.zawadzki@gmail.com  '

  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.require_paths = ['lib']
  s.license       = 'MIT'
  s.required_ruby_version = '>= 3.1'
  s.add_dependency 'activesupport', '~> 7.0'
  s.add_development_dependency 'pry', '~> 0.13'
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'rubocop', '~> 1.0'
  s.add_development_dependency 'rubocop-rspec', '~> 2.2'
  s.metadata['rubygems_mfa_required'] = 'false'
end
