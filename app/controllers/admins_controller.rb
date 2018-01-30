class AdminsController < ApplicationController
	before_action :require_admin
	layout 'admin_application'

  def index
  end
end
