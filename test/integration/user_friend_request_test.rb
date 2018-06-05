require 'test_helper'

class UserFriendRequestTest < ActionDispatch::IntegrationTest
  def setup
    @user  = User.create(name: "dave", email: "dave@email.com",
                        password: "password", password_confirmation: "password")
    @other = User.create(name: "boby", email: "boby@email.com",
                        password: "password", password_confirmation: "password")

  end

  test 'user can send a friend request' do
    post user_session_path params: { user: { email: @user.email, password: "password" }}
    assert_redirected_to posts_path
    assert_difference '@user.sent_requests.pending.count', 1 do
      post friend_requests_path params: { friend_request: { resquestor_id: @user.id,
                                           requested_id: @other.id } }
      assert_redirected_to user_path(@other)
    end
    assert_not_empty @other.received_requests.pending
  end
  test 'user can answer a friend request' do
    #create a new friend requests and record its id
    @other.sent_requests.create!(requested_id: @user.id)
    request = FriendRequest.last.id

    post user_session_path params: { user: { email: @user.email, password: "password" }}
    assert_difference 'FriendRequest.all.count',1 do
      assert_difference '@user.friends.count', 1 do
        patch friend_request_path(request), params: {
                                                  friend_request: { accepted: 1 }}
      end
    end
    assert_not_empty @other.friends
    assert_empty     @user.received_requests.pending
    assert_empty     @other.sent_requests.pending
  end
end
