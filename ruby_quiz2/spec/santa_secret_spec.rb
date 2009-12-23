#!/usr/bin/env ruby

require 'santa_secret'

describe SantaSecret do
  
  before(:each) do
    @persons = [
      "Daniel Braz <daniel@ideaworks.com.br>",
      "Luke Skywalker <luke@theforce.net>",
      "Gus Portokalos <gus@weareallfruit.net>",
      "Bruce Wayne <bruce@imbatman.com>",
      "Virgil Brigman <virgil@rigworkersunion.org>",
      "Leia Skywalker <leia@therebellion.org>",
      "Lindsey Brigman <lindsey@iseealiens.net>",
      "Fabiana Braz <fabiana@ideaworks.com.br>",
      "Toula Portokalos <toula@manhunter.org>"
    ]
  end

  it "should only accept an odd size array as input" do
    lambda { SantaSecret.new(@persons) }.should_not raise_error(StandardError)
  end

  it "should accept persons with valid email addr" do
    lambda { SantaSecret.new(@persons) }.should_not raise_error(StandardError)
  end

  it "should not accept persons with invalid email addr" do
    persons = @persons.dup
    persons.push("jose silva")
    lambda { SantaSecret.new(persons) }.should raise_error(StandardError)
  end

  it "should build a not empty hash with Santas pair" do
    santa = SantaSecret.new(@persons)
    pairs = santa.choosePairs
    pairs.should be_instance_of(Hash)
    pairs.should_not be_empty
  end
  
  it "should not allow people to be their own Santa" do
    santa = SantaSecret.new(@persons)
    pairs = santa.choosePairs
    pairs.each do |key,value|
      key.should_not be_equal(value)
    end
  end
  
  it "should not allow people in the same family to be Santas for each other" do
    santa = SantaSecret.new(@persons)
    pairs = santa.choosePairs
    pairs.each do |person,other_person|
      familly_name = person.match(/ [a-zA-Z0-9]+ /)
      other_familly_name = other_person.match(/ [a-zA-Z0-9]+ /)
      familly_name.should_not be_equal(other_familly_name)
    end
  end
  
  it "should not left people without a pair" do
    santa = SantaSecret.new(@persons)
    pairs = santa.choosePairs
    pairs.keys.size.should be_equal(@persons.size)
  end
  
end