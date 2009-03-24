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
  class Container

    def initialize
      @dic = Dictionary.new
      @pool = {}
      @checked = false
    end

    def add klass
      @checked = false

      d = Definition.new klass
      @dic.add d
    end

    def get key
      check_dictionary

      if cached = @pool[key]
        return cached
      else
        obj = lookup_and_setup key
        @pool[key] = obj

        obj
      end
    end

    private
    def check_dictionary
      unless @chekced
        @dic.check_constructor_dependency
        @checked = true
      end
    end
    def lookup_and_setup key
      d = @dic.lookup key
      obj = instatiate d
      setup_properties obj, d
      
      obj
    end

    def instatiate d
      klass = d.source
      args  = instantiate_args d

      klass.new *args
    end
    def instantiate_args d
      d.constructor_depends.map do |dep|
        get dep
      end
    end
    def setup_properties obj, d
      d.property_depends.each do |dep|
        obj.__send__ "#{dep.to_s.downcase}=", get(dep)
      end
    end
  end
end
