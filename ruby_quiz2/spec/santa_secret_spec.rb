#!/usr/bin/env ruby

require 'santa_secret'

describe SantaSecret do
  
  before(:each) do
    @emails = [
      "Luke Skywalker <luke@theforce.net>",
      "Leia Skywalker <leia@therebellion.org>",
      "Toula Portokalos <toula@manhunter.org>",
      "Gus Portokalos <gus@weareallfruit.net>",
      "Bruce Wayne <bruce@imbatman.com>",
      "Virgil Brigman <virgil@rigworkersunion.org>",
      "Lindsey Brigman <lindsey@iseealiens.net>",
      "Daniel Braz <daniel@ideaworks.com.br>",
      "Fabiana Braz <fabiana@ideaworks.com.br>"
    ]
  end

  it "should only accept an odd size list as input" do
    lambda { SantaSecret.new(@emails) }.should_not raise_error(StandardError)
  end

  it "should accept valid email addr" do
    lambda { SantaSecret.new(@emails) }.should_not raise_error(StandardError)
  end

  it "should not accept invalid email addr" do
    emails = @emails.dup
    emails.push("jose silva")
    lambda { SantaSecret.new(emails) }.should raise_error(StandardError)
  end

  it "should build a not empty hash with Santas pair" do
    santa = SantaSecret.new(@emails)
    pairs = santa.choosePairs
    pairs.should be_instance_of(Hash)
    pairs.should_not be_empty
  end
  
  it "should not allow people to be their own Santa" do
    santa = SantaSecret.new(@emails)
    pairs = santa.choosePairs
    pairs.each do |key,value|
      key.should_not be_equal(value)
    end
  end
  
  it "should not allow people in the same family to be Santas for each other" do
    santa = SantaSecret.new(@emails)
    pairs = santa.choosePairs
    pairs.each do |key,value|
      key_familly_name = key.match(/ [a-zA-Z0-9]+ /)
      value_familly_name = value.match(/ [a-zA-Z0-9]+ /)
      key_familly_name.should_not be_equal(value_familly_name)
    end
  end
  
  it "should not left people without a pair" do
    santa = SantaSecret.new(@emails)
    pairs = santa.choosePairs
    pairs.keys.size.should be_equal(@emails.size)
  end
  
end