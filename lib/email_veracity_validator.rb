require 'active_model'

module ActiveModel
  module Validations


    class EmailVeracityValidator < ActiveModel::EachValidator
    
      #
      # Simple validation on model
      # validates :email, :email_veracity => true 
      #
      # Or with OPTIONS
      # validates :email, :email_veracity => { ... }
      #
      # Options (and their default values)
      #
      # :skip_lookup => false
      #   When set to true, the domain is not checked for a valid server or MX record.  This is
      #   definitely faster, but will accempt obvious typos like 'user@yahoo.cm'
      #
      # :timeout => 2
      #   Set the timeout on lookup (in seconds). 
      #
      # :enforce_whitelist => true
      #   Don't look up servers we already know about.  The included whitelist includes:
      #     aol.com, gmail.com, hotmail.com, me.com, mac.com, msn.com, rogers.com, 
      #     sympatico.ca, yahoo.com, telus.com, sprint.com, sprint.ca
      #
      # :enforce_blacklist => false
      #   Don't allow email addresses that are from common spam hosts. Blacklist includes:
      #     dodgeit.com, mintemail.com, mintemail.uni.cc, 1mintemail.mooo.com, spammotel.com, trashmail.net
      #
      # :valid_pattern => /Extensive - see config.rb/
      #   A regular expression to check addresses against.
      #
      # :must_include => []
      #   Set which records are required to be searched for lookup.  Options include :a and :mx.
      #   When left empty, both A and MX are searched.
      #
    
      def initialize(options = {})
        super(EmailVeracity::Config::DEFAULT_OPTIONS.merge(options))
      end
        
      def validate_each(record, attribute, value)        
        # we aren't interested in reproducing the :presence => true 
        # functionality of rails.  Since blank emails return :malformed as
        # an error, let's just skip those
        unless value.blank?

          old_options = EmailVeracity::Config.options.clone
          EmailVeracity::Config.options = options
          
          address = EmailVeracity::Address.new value
          unless address.valid?
            record.errors.add attribute, I18n.t(address.errors.first.to_s, :scope => 'activerecord.errors.messages.email_veracity')
          end
        end
          
        
        EmailVeracity::Config.options = old_options if old_options
        
      end
    
    end
  

  
  end
end
