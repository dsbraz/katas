#!/usr/bin/env ruby

class SantaSecret
  
  def initialize(persons)
    @persons = persons
    validate_array_size!
    validate_array_content!
  end
  
  def choosePairs
    pairs = Hash.new
    other_persons = @persons.dup
    @persons.each do |person|
      other_person = fetch_pair(person, other_persons)
      pairs.store(person, other_person)
      other_persons.delete(other_person)
    end
    return pairs
  end
  
  private
    
    def fetch_pair(person, other_persons)
      other_person = fetch_rand_person(other_persons)
      while from_same_familly?(person, other_person) && other_persons.size > 2
        other_person = fetch_rand_person(other_persons)
      end
      return other_person
    end
    
    def from_same_familly?(person, other_person)
      familly_name = get_familly_name(person)
      familly_name_from_other = get_familly_name(other_person)
      return familly_name.to_s == familly_name_from_other.to_s
    end
    
    def fetch_rand_person(persons)
      persons.fetch(rand(persons.size))
    end
    
    def get_familly_name(person)
      person.match(/ [a-zA-Z0-9]+ /)
    end
    
    def validate_array_size!
      raise StardardError.new("Invalid array size") unless odd_size_array? @persons
    end

    def odd_size_array?(array)
      array.size % 2 != 0
    end
    
    def validate_array_content!
      @persons.each do |person|
        raise StandardError.new("invalid email: #{email}") unless valid_email? person
      end
    end
  
    def valid_email?(email)
      # xxx xxx <xxx@xxx.xxx.xx>
      regex = %r{^[a-zA-Z]+ [a-zA-Z]+ <{1}[a-zA-Z0-9\._]+[^\.]@{1}[a-zA-Z0-9]+\.{1}[a-zA-Z0-9]+(\.{1}[a-zA-Z0-9]{2})?>{1}$}i
      email.match regex
    end
  
end
