require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  before(:each) do
    sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
    @group = @user.groups.create(name: "My First Group", group_type: "Social", description: "Welcome to my group!")
    @member_ship = MemberShip.find_by(group_id: @group.id, user_id: @user.id)
    @member_ship.is_owner = true
    @member_ship.is_admin = true
    @member_ship.save
  end
  context "Crud with post" do
    it "#index" do
      get :index
    end
    it "new group page" do
      get :new
    end
    it "create group page success" do
      post :create, params: { group: { name: "My Group", group_type: "Social", description: "Welcome to my group!" } }
      expect(Group.where(name: "My Group", group_type: "Social", description: "Welcome to my group!").size).to eq 1
    end
    it "create group page failed" do
      post :create, params: { group: { name: "My Group", group_type: "", description: "Welcome to my group!" } }
      expect(Group.where(name: "My Group", description: "Welcome to my group!").size).to eq 0
    end
    it "update grouop profile complete" do
      put :update, params: { id: @group.id, group: { name: "My Second Group", group_type: "Social", description: "Welcome to my group!" } }
      expect(Group.find(@group.id).name).to eq "My Second Group"
    end
    it "update grouop profile complete" do
      put :update, params: { id: @group.id, group: { name: "My Second Group", group_type: "", description: "Welcome to my group!" } }
      expect(Group.find(@group.id).name).not_to eq "My Second Group"
    end
    it "delete group success" do
      delete :destroy, params: { id: @group.id }
      expect(Group.where(id: @group.id).size).to eq 0
    end
    it "delete group failed" do
      @other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
      @member_ship.user = @other_user
      @member_ship.save
      delete :destroy, params: { id: @group.id }
      expect(Group.where(id: @group.id).size).to eq 1
    end
  end
  context "Check if member is belong to group" do
    it "true" do
      expect(@group.has_member(@user)).to be true
    end

    it "false" do
      @other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
      expect(@group.has_member(@other_user)).to be false
    end
  end
end
