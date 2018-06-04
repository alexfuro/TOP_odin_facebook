require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
   @user = User.create!(name: "joe", email: "joe@email.com",
                         password: "password", password_confirmation: "password")
  end

  test 'requires sign in' do
    get users_path
    assert_redirected_to new_user_session_path

    get user_path(@user)
    assert_redirected_to new_user_session_path

    get edit_user_path(@user)
    assert_redirected_to new_user_session_path
  end

  test 'displays pages after login' do
    post user_session_path params: { user: { email: @user.email, password: "password" } }
    assert_redirected_to root_path

    get users_path
    assert_response :success

    get user_path(@user)
    assert_response :success

    get edit_user_path(@user)
    assert_response :success
  end
end
