require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user  = User.new(name: "smith", email: "example@email.com",
                      password: "password", password_confirmation: "password")
    @other = User.create(name: "Joey", email: "joey@email.com",
                      password: "password", password_confirmation: "password")
    @another = User.create(name: "Will", email: "will@email.com",
                      password: "password", password_confirmation: "password")
    @third = User.create(name: "Tom", email: "tom@email.com",
                      password: "password", password_confirmation: "password")
    @other.sent_requests.create(requested_id: @another.id)
    @other.sent_requests.create(requested_id: @third.id, accepted: true)
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

  test 'can show new user has no friends' do
    assert_empty @user.friends
  end

  test 'can check if user has unaswered friend requests' do
    assert_not_empty @another.received_requests.pending
  end

  test 'can check if user has sent friend requests' do
    assert_not_empty @other.sent_requests.pending
  end

  test 'can find the friends a user has' do
    assert_not_empty @other.friends
  end

  test 'can distinguis an answered friend requests' do
    assert_empty     @third.received_requests.pending
    assert_not_empty @third.received_requests
  end
end
