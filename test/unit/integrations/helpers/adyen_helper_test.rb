require 'test_helper'

class AdyenHelperTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def setup
    @helper = Adyen::Helper.new('order-500','cody@example.com', :amount => 500, :currency => 'USD')
  end
 
  def test_basic_helper_fields
    assert_field 'merchantAccount',   'cody@example.com'
    assert_field 'paymentAmount',     '500'
    assert_field 'merchantReference', 'order-500'
  end
  
  def test_customer_fields
    @helper.customer :email => 'cody@example.com'
    assert_field 'shopperEmail', 'cody@example.com'
  end

  def test_address_mapping
    @helper.billing_address :address1 => '1 My Street',
                            :address2 => '',
                            :city => 'Leeds',
                            :state => 'Yorkshire',
                            :zip => 'LS2 7EE',
                            :country  => 'CA'

    assert_field 'billingAddress.street',          '1 My Street'
    assert_field 'billingAddress.city',            'Leeds'
    assert_field 'billingAddress.stateOrProvince', 'Yorkshire'
    assert_field 'billingAddress.postalCode',      'LS2 7EE'
  end
  
  #def test_unknown_address_mapping
  #  @helper.billing_address :farm => 'CA'
  #  assert_equal 3, @helper.fields.size
  #end

  #def test_unknown_mapping
  #  assert_nothing_raised do
  #    @helper.company_address :address => '500 Dwemthy Fox Road'
  #  end
  #end
  #
  #def test_setting_invalid_address_field
  #  fields = @helper.fields.dup
  #  @helper.billing_address :street => 'My Street'
  #  assert_equal fields, @helper.fields
  #end
end
