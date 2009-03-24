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

module ObjectInjection
  class Definition
    attr_reader :constructor_depends
    attr_reader :property_depends
    attr_reader :provides
    attr_reader :source

    def initialize klass
      @source   = klass
      @provides = extract_provides klass
      @property_depends  = extract_property_depends klass
      @constructor_depends = extract_constructor_depends klass
    end

    def to_sym
      to_class_name(@source).to_sym
    end

    def eql? other
      self.source.eql? other.source
    end
    
    def hash
      self.source.hash
    end

    private
    def extract_provides klass
      name  = to_class_name(klass)
      cases = split_camelcase(name)
      join_as_sym(cases)
    end

    def extract_property_depends klass
      methods = klass.public_instance_methods
      methods.grep(/^(\w+)=$/){ |m|
        snail_to_camel($1).to_sym
      }
    end

    def extract_constructor_depends klass
      params = klass.instance_method(:initialize).parameters
      params.map {|p|
        snail_to_camel(p.last.to_s).to_sym
      }
    end

    def to_class_name klass
      fqn =  klass.name or
        raise DefinitionError.new("Anonymous class is not supported.")
      fqn.split('::').last
    end

    def split_camelcase name
      name.scan(/[A-Z][a-z0-9_]*/)
    end

    def join_as_sym(cases)
      cases.map.with_index do |c, i|
        cases[i, cases.size].join.to_sym
      end
    end

    def snail_to_camel pattern
      pattern.split('_').map(&:capitalize).join
    end
  end
end
