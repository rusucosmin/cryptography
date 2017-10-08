require 'test_helper'

class EncryptFlowTest < ActionDispatch::IntegrationTest
  test "user encrypting with default parameters" do
    # user gets to the home page
    get "/"
    assert_equal 200, status
    # user posts default parameters
    post "/encrypt", params: { "alphabet" => "abcdefghijklmnopqrstuvwxyz",
                       "alpha" => 1,
                       "beta" => 1,
                       "text" => "text to encrypt" }
    assert_equal 200, status
    assert_select 'code', 'ufyu up fodszqu'
  end

  test "user encrypting the alphabet on ceasar" do
    # user gets to the home page
    get "/"
    assert_equal 200, status
    # user posts default parameters
    post "/encrypt", params: { "alphabet" => "abcdefghijklmnopqrstuvwxyz",
                       "alpha" => 1,
                       "beta" => 1,
                       "text" => "abcdefghijklmnopqrstuvwxyz" }
    assert_equal 200, status
    assert_select 'code', 'bcdefghijklmnopqrstuvwxyza'
  end
end
