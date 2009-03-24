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
  class Dictionary
    def initialize
      @definitions = []
      @providings = {}
    end
    def add d
      if @definitions.find {|i| i.eql? d }
        raise DuplicateDefinitionError.new("#{d.source} is duplicate.")
      end
      @definitions.push d
      add_providings_to_map d
    end
    def lookup key
      @providings[key]
    end
    def check_constructor_dependency
      @definitions.each do |d|
        scan_dependencies @definitions.dup, d
      end
    end

    private
    def add_providings_to_map d
      d.provides.each do |k|
        add_or_remove_keywords k, d
      end
    end
    def add_or_remove_keywords k, d
      unless @providings[k]
        @providings[k] = d
      else
        # remove ambiguous keyword.
        @providings.delete k
      end
    end
    def scan_dependencies defs, d
      d.constructor_depends.each do |dep|
        found = lookup(dep) or
          raise DependencyNotFoundError.new("#{d} depends on #{dep} but not found}")
        defs.delete(found) or
          raise CircularReferenceError.new

        scan_dependencies defs, found
      end
    end
  end
end
