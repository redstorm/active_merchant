require 'test_helper'

class AdyenNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @adyen = Adyen::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @adyen.complete?
    assert_equal "", @adyen.status
    assert_equal "", @adyen.transaction_id
    assert_equal "", @adyen.item_id
    assert_equal "", @adyen.gross
    assert_equal "", @adyen.currency
    assert_equal "", @adyen.received_at
    assert @adyen.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @adyen.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement    

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @adyen.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    ""
  end  
end
