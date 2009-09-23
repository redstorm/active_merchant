require 'base64'
require 'stringio'
require 'zlib'
require 'openssl'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Adyen
        class Return < ActiveMerchant::Billing::Integrations::Return

          # for verifying the signature of the URL parameters returned by Adyen after the payment process
          PAYMENT_RESULT_SIGNATURE_FIELDS = [
            :authResult,
            :pspReference,
            :merchantReference,
            :skinCode
          ]

          def generate_signature_string
            PAYMENT_RESULT_SIGNATURE_FIELDS.map {|key| @fields[key.to_s]} * ""
          end

          def generate_signature
            digest = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, @shared_secret, generate_signature_string)
            return Base64.encode64(digest).strip
          end
          
          def signature_is_valid?
            puts "*"*100
            puts "checking signature...."
            puts "is #{generate_signature} == #{params['merchantSig']} ?"
            puts "*"*100
            generate_signature == params['merchantSig']
          end

          def payment_authorized?
            params['authResult'] == 'AUTHORISED'
          end
  
#http://localhost:3000/done?merchantReference=1234
#skinCode=fVmBwBe3
#shopperLocale=en_GB
#paymentMethod=visa
#authResult=REFUSED
#pspReference=8712536768221232
#merchantSig=SMbs3j04uaxncsQl3SqXmzp4IbQ%3D
          def success?
            signature_is_valid? and payment_authorized?
          end

          def message
            params['authResult']
          end

        end
      end
    end
  end
end

