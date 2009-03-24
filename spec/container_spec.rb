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

describe ObjectInjection::Container do

  include ObjectInjection

  before :each do
    @container = Container.new
  end

  context "with property injection" do
    class Juicer
      attr_accessor :fruit
    end

    class Fruit
    end

    it "should return instance of added class when #get (1)" do
      @container.add Fruit
      @container.get(:Fruit).should be_a Fruit
    end

    it "should return instance of added class when #get (2)" do
      @container.add Fruit
      @container.add Juicer
      
      juicer = @container.get(:Juicer)
      juicer.should be_a Juicer
      juicer.fruit.should be_a Fruit
    end
  end
  
  context "with constructor injection" do
    class Juicer
      def initialize fruit
      end
    end

    class Fruit
    end

    it "should return instance of juicer" do
      @container.add Fruit
      @container.add Juicer
      
      juicer = @container.get(:Juicer)
    end
  end

  context "generic behaviour" do
    class Fruit; end

    it "should be same instances" do
      @container.add Fruit
      @container.get(:Fruit).should equal @container.get(:Fruit) 
    end
  end

end

