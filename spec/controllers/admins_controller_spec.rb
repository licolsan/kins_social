require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", is_admin: true, email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
    @other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	end
  context "Send email" do
    it "account problem" do
      post :send_problem_email, params: { id: @other_user.id }
    end
  end
end
