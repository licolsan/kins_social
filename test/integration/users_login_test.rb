require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:one)
  end

  test "login with valid information" do
  	# get log_in_path
  	# post login_path, params: {
  	# 	sess: {
  	# 		email: @user.email,
  	# 		password: @user.password
  	# 	}
  	# }
  	# assert_redirected_to @user
  	# follow_redirect!
  	# assert_template 'pages/index'
  	# assert_select "a[href=?]", log_in_path, count: 0
  	# assert_select "a[href=?]", log_out_path
  end
end
