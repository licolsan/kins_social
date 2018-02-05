require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  before(:each) do
		sign_in @user = create(:user)
    @other_user = create(:user)
	end
  context "Send email" do
    it "account problem" do
      @user.update_attribute(:is_admin, true)
      post :send_problem_email, params: { id: @other_user.id }
    end
  end
end
