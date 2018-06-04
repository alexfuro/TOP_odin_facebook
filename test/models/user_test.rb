require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "smith", email: "example@email.com",
                     password: "password", password_confirmation: "password")
  end

  test 'does not allow blank name' do
    @user.name = ""
    assert_not @user.valid?
  end

  test 'does not allow blank email' do
    @user.email = ""
    assert_not @user.valid?
  end

  test 'does not allow invalid email' do
    @user.email = "example"
    assert_not @user.valid?
  end

  test 'does allow valid parameters' do
    assert @user.valid?
  end
end
