class AdminsController < ApplicationController
	before_action :require_admin
	before_action :find_user, only: [ :send_problem_email ]
	layout 'admin_application'

  def index
  end

	def send_problem_email
		UserMailer.account_problem(@user).deliver_now
		flash[:notice] = "Send message complete"
		redirect_back(fallback_location: root_path)
	end

	private
	def find_user
		@user = User.find(params[:id])
	end
end
