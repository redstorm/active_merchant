require 'test_helper'

class AdyenReturnTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_successful_return
    r = Adyen::Return.new('merchantReference=1234&skinCode=fVmBwBe3&shopperLocale=en_GB&paymentMethod=visa&authResult=REFUSED&pspReference=8712536782211284&merchantSig=VSGVisHs1QAq69kMDsdH1pF9mbI%3D')
    assert r.success?
    assert_equal HiTrust::Return::SUCCESS, r.params['retcode']
    assert_equal HiTrust::Return::CODES[HiTrust::Return::SUCCESS], r.message
  end
  
  def test_failed_return
    r = HiTrust::Return.new('retcode=-100')
    assert_false r.success?
    assert_equal HiTrust::Return::CODES['-100'], r.message
  end
  
  def test_unknown_return
    r = HiTrust::Return.new('retcode=unknown')
    assert_false r.success?
    assert_nil r.message
  end
end

