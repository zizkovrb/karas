require 'test_helper'

class TestKaras < MiniTest::Unit::TestCase
  def test_karas_valid_echo
    assert_equal 'ryba', Karas.evaluate("echo 'ryba';")
  end

  def test_karas_valid_code
    assert_equal true, Karas.evaluate("$a = 1;")
  end

  def test_karas_invalid_code
    assert_equal false, Karas.evaluate("echo ryba'")
  end
end
