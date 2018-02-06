require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:jerry)
  end

  test 'user should be valid' do
    assert @user.valid?
  end

  test 'handle should be present' do
    @user.handle = ''
    assert_not @user.valid?
  end

  test 'handle should be no longer than 15 chars' do
    @user.handle = 'a' * 16
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be saved with all lower case' do
    mixed_case_email = 'jErRy@rails.com'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
