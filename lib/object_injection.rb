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

if RUBY_VERSION < '1.9.1'
  raise "ObjectInjection requires Ruby 1.9.1 or later."
else
  require 'rubygems'
  require 'methopara' if RUBY_VERSION == '1.9.1'
  
  require 'object_injection/container.rb'
  require 'object_injection/definition.rb'
  require 'object_injection/dictionary.rb'
  require 'object_injection/errors.rb'
end
