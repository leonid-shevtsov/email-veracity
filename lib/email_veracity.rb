require 'resolv'
require 'timeout'

require 'email_veracity/utils'
require 'email_veracity/validatability'
require 'email_veracity/config'
require 'email_veracity/server'
require 'email_veracity/resolver'
require 'email_veracity/domain'
require 'email_veracity/address'
require 'email_veracity_validator'

module EmailVeracity

  class Error < StandardError; end
  class MalformedEmailAddressError < Error; end
  class DomainResourcesTimeoutError < Error; end

end

