#!/usr/bin/env ruby

class SantaSecret
  
  def initialize(emails)
    @emails = emails
    if emails.size % 2 == 0
      raise StardardError.new("Invalid size")
    end
    emails.each do |email|
      if not valid_email? email
        raise StandardError.new("invalid email: #{email}")
      end
    end
  end
  
  def choosePairs
    pairs = Hash.new
    value_emails = @emails.dup
    @emails.each do |key_email|
      key_familly_name = key_email.match(/ [a-zA-Z0-9]+ /)
      value_email = value_emails.fetch(rand(value_emails.size))
      value_familly_name = value_email.match(/ [a-zA-Z0-9]+ /)
      while key_familly_name.to_s == value_familly_name.to_s and value_emails.size > 2
        value_email = value_emails.fetch(rand(value_emails.size))
        value_familly_name = value_email.match(/ [a-zA-Z0-9]+ /)
      end
      value_emails.delete(value_email)
      pairs.store(key_email, value_email)
    end
    return pairs
  end
  
  private
    def valid_email?(email)
      # xxx xxx <xxx@xxx.xxx.xx>
      re = %r{^[a-zA-Z]+ [a-zA-Z]+ <{1}[a-zA-Z0-9\._]+[^\.]@{1}[a-zA-Z0-9]+\.{1}[a-zA-Z0-9]+(\.{1}[a-zA-Z0-9]{2})?>{1}$}i
      email.match re
    end
  
end