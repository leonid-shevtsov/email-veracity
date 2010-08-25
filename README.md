# Email Veracity

A straight-forward Ruby library for checking the real-world validity of email
addresses that you should probably not use.

## It Can

 * Validate email addresses for proper form against a pattern.
 * Accept and reject addresses based whitelists and blacklists of domains.
 * Check an address' domain for MX and/or A records.
 * Be configured for a variety of use-cases, to be as discerning or as
   indiscriminate as you would like.

## A Note About This Gem

I don't condone it for email validation. If you must be sure an address is
real then you should send a verification message. Otherwise, relax :-)

## Using The Gem

Consider the following examples:
    
    require 'email_veracity'
    
    address = EmailVeracity::Address.new('heycarsten@gmail.com')
    
    address.valid?
    # => true
    
    address.domain.to_s
    # => 'gmail.com'
    
    address.domain.address_servers.map { |s| s.to_s }
    # => ["64.233.171.83", "64.233.161.83", "209.85.171.83"]
    
    address = EmailVeracity::Address.new('fakey@crazy-z3d9df-domain.com')
    
    address.valid?
    # => false
    
    address.errors
    # => [:no_address_servers]

As you can see, playing with the core library is pretty fun.  The basic building
blocks are:

#### Address

Responsible for parsing full email addresses and checking for pattern-based
validity.

#### Domain

Contains methods to query the domain for information.

#### Resolver

Abstracts Resolv::DNS into a super-simple single public method, this is where
the timeout error is raised.


## Rails 3 Validator

Rails 3 Validator now included.  

    validates :email, :email_veracity => true 

    
You can also validate with options.

    validates :email, :email_veracity => { :option => value } 
    
### Validation Options 

#### skip_lookup _(false)_      
When set to true, the domain is not checked for a valid server or MX record.  This is
definitely faster, but will accempt obvious typos like 'user@yahoo.cm'

#### timeout _(2)_
      
Set the timeout for DNS lookup (in seconds). 

#### enforce_whitelist _(true)_
Don't look up servers we already know about.  The included whitelist includes:
aol.com, gmail.com, hotmail.com, me.com, mac.com, msn.com, rogers.com, 
sympatico.ca, yahoo.com, telus.com, sprint.com, sprint.ca
 
#### enforce_blacklist _(false)_
Don't allow email addresses that are from common spam hosts. Blacklist includes:
dodgeit.com, mintemail.com, mintemail.uni.cc, 1mintemail.mooo.com, spammotel.com, trashmail.net

#### valid_pattern _(see config.rb)_

A regular expression to check addresses against.

#### must_include _([])_
Set which records are required to be searched for lookup.  Options include :a and :mx.
When left empty, both A and MX are searched.