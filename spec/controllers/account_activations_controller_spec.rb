require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
	context "Confirm email" do
		it "click activate link completed" do
			@user = User.create(name: "abc", email: "a@a", password: "123", password_confirmation: "123")
			get :edit, params: { id: @user.activation_token, email: @user.email }
			expect(User.find(@user.id).activated).to eq true
		end
		it "click activate link failed" do
			@user = User.create(name: "abc", email: "a@a", password: "123", password_confirmation: "123")
			get :edit, params: { id: @user.activation_digest, email: @user.email }
			expect(User.find(@user.id).activated).to eq false
		end
	end
end
