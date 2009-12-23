#!/usr/bin/env ruby

class SantaSecret
  
  def initialize(persons)
    @persons = persons
    validate_array_size!
    validate_array_content!
  end
  
  def choosePairs
    pairs = Hash.new
    persons_to_choose = @persons.dup
    @persons.each do |person|
      chosen_person = fetch_pair!(person, persons_to_choose)
      pairs.store(person, chosen_person)
    end
    return pairs
  end
  
  private
    
    def fetch_pair!(person, persons_to_choose)
      persons_to_choose.delete(person)
      chosen_person = fetch_rand_person(persons_to_choose)
      persons_to_choose.delete(chosen_person)
      persons_to_choose.push(person)
      return chosen_person
    end
    
    def fetch_rand_person(persons)
      persons.fetch(rand(persons.size))
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
