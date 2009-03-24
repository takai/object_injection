# -*- mode: ruby; coding: utf-8-unix -*-
#
# Copyright 2009 Naoto Takai
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Gem::Specification.new do |spec|
  spec.name = 'object_injection'
  spec.version = '0.1.1'

  spec.authors = ['Naoto Takai']
  spec.date = '2009-03-24'
  spec.description = 'ObjectInjection is dependency injection container.'
  spec.email = 'takai@recompile.net'
  spec.files = %w{
    LICENSE
    README
    lib
    lib/object_injection
    lib/object_injection/container.rb
    lib/object_injection/dictionary.rb
    lib/object_injection/definition.rb
    lib/object_injection/errors.rb
    lib/object_injection.rb
    object_injection.gemspec
    spec
    spec/dictionary_spec.rb
    spec/spec.opts
    spec/spec_helper.rb
    spec/definition_spec.rb
    spec/container_spec.rb
  }
  spec.has_rdoc = true
  spec.homepage = 'http://github.com/takai/object_injection/'
  spec.rdoc_options = ['--inline-source', '--charset=UTF-8']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.1'
  spec.rubygems_version = '1.3.1'
  spec.summary = 'Dependency injection container for Ruby.'
end
