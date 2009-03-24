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

require "#{File.dirname(__FILE__)}/spec_helper"

describe ObjectInjection::Definition do

  include ObjectInjection

  class Manager; end
  class ObjectManager; end
  class SingletonObjectManager; end
  module Nested
    module Nested
      class Manager; end
    end
  end
  class A; end

  it "should hold source class" do
    Definition.new(Manager).source.should equal Manager
  end

  it "should know providings of given class" do
    m = Definition.new Manager
    m.provides.should eql [:Manager]
    om = Definition.new ObjectManager
    om.provides.should eql [:ObjectManager, :Manager]
    som = Definition.new SingletonObjectManager
    som.provides.should eql [:SingletonObjectManager, :ObjectManager, :Manager]
    nnm = Definition.new Nested::Nested::Manager
    nnm.provides.should eql [:Manager]
    a = Definition.new A
    a.provides.should eql [:A]
  end

  it "should raise DefinitionError when anonymous class is passed" do
    ->{ Definition.new Class.new }.should raise_error DefinitionError
  end

  it "should know property dependencies of given class" do
    class Juicer
      attr_writer :fruit
      attr_writer :fruit_mix
    end
    
    j = Definition.new Juicer
    j.property_depends.should eql [:Fruit, :FruitMix]
  end

  it "should know constructor dependencies of given class" do
    class Juicer
      def initialize fruit, fruit_mix
      end
    end
    class Fruit
    end

    j = Definition.new Juicer
    j.constructor_depends.should eql [:Fruit, :FruitMix]
    f = Definition.new Fruit
    f.constructor_depends.should eql []
  end

  it "should convert to symbol" do
    Definition.new(Manager).to_sym.should eql :Manager 
    Definition.new(ObjectManager).to_sym.should eql :ObjectManager
  end

  it "should eql having same source" do
    Definition.new(Manager).should eql Definition.new(Manager)
  end

end

