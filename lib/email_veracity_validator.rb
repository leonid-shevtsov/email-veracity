require 'active_model'

module ActiveModel
  module Validations


    class EmailVeracityValidator < ActiveModel::EachValidator
      
      def initialize(options)
        super #(options.reverse_merge(:allow_nil => false))
      end
      
      def validate_each(record, attribute, value)
        # we aren't interested in reproducing the :presence => true 
        # functionality of rails.  Since blank emails return :malformed as
        # an error, let's just skip those
        unless value.blank?
          address = EmailVeracity::Address.new value
          unless address.valid?
            case
            when address.errors.include?(:malformed)
              record.errors.add attribute, 'does not look like a valid email address'
            when address.errors.include?(:no_records)
              record.errors.add attribute, 'does ont appear to be a real email address'
            end
          end
        end
      end
      
      module ClassMethods

        def validates_email_veracity_of(*attr_names)
          validates_with EmailVeracityValidator, _merge_attributes(attr_names)
        end

      end

    end

    
  end
end
