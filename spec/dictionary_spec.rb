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

describe ObjectInjection::Dictionary do

  include ObjectInjection

  class Term; end
  class TechnicalTerm; end
  class LegalTerm; end

  class A
    def initialize b
    end
  end

  class B
    def initialize c
    end
  end

  class C
    def initialize a
    end
  end
  
  class D
    def initialize e
    end
  end
 
  class E
  end

  class F
    def initialize h
    end
  end
  class G
    def initialize h
    end
  end
  class H
  end
  
  before :each do
    @dic = Dictionary.new
  end

  it "should look-up definition by provides" do
    tt = Definition.new TechnicalTerm
    @dic.add tt
    @dic.lookup(:Term).should eql tt
  end

  it "should return nil when ambiguous term is added" do
    tt = Definition.new TechnicalTerm
    lt = Definition.new LegalTerm
    @dic.add tt
    @dic.add lt
    @dic.lookup(:TechnicalTerm).should eql tt
    @dic.lookup(:LegalTerm).should eql lt
    @dic.lookup(:Term).should be_nil
  end

  it "should raise error when circular reference found" do
    @dic.add Definition.new(A)
    @dic.add Definition.new(B)
    @dic.add Definition.new(C)
    
    -> {
      @dic.check_constructor_dependency
    }.should raise_error CircularReferenceError
  end

  it "should not raise error when circular reference is not found (1)" do
    @dic.add Definition.new(D)
    @dic.add Definition.new(E)

    -> {
      @dic.check_constructor_dependency
    }.should_not raise_error
  end

  it "should not raise error when circular reference is not found (2)" do
    @dic.add Definition.new(F)
    @dic.add Definition.new(G)
    @dic.add Definition.new(H)

    -> {
      @dic.check_constructor_dependency
    }.should_not raise_error
  end

  it "should raise error when duplicate definition is added" do
    -> {
      @dic.add Definition.new(Term)
      @dic.add Definition.new(Term)
    }.should raise_error DuplicateDefinitionError
  end

end
