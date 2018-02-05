require 'rails_helper'

RSpec.describe MemberShipsController, type: :controller do
	before(:each) do
		sign_in @user = create(:user)
		@other_user = create(:user)
		@group = @user.groups.create(name: "My First Group", group_type: "Social", description: "Welcome to my group!")
    @member_ship = MemberShip.find_by(group_id: @group.id, user_id: @user.id)
    @member_ship.is_owner = true
    @member_ship.is_admin = true
    @member_ship.save
	end

	it "#new" do
		get :new, params: { group_id: @group.id }
	end

	context "Add member to group" do
		it "added" do
			post :create, params: { group_id: @group.id, user_id: [ @other_user.id ] }
			expect(@group.member_ships.where(user_id: @other_user.id).size).to eq 1
		end
		it "add failed" do
			post :create, params: { group_id: @group.id, user_id: [] }
			expect(@group.member_ships.where(user_id: @other_user.id).size).to eq 0
		end
	end

	context "#destroy" do
		it "leave group" do
			new_member_ship = @group.member_ships.create(user_id: @other_user.id, is_owner: true, is_admin: true)
			delete :destroy, params: { group_id: @group.id, id: @other_user.id }
			expect(@group.member_ships.where(user_id: @other_user.id).size).to eq 0
		end
	end
end
