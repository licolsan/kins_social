class ReportsController < ApplicationController
	before_action :find_post

	def create
		report = find_report(current_user)
		if report
			flash[:notice] = "You have benn report this post already!"
		else
			report = @post.reports.new(report_params)
			report.user_id = current_user.id
			if report.save
				flash[:notice] = "Your report has been saved!"
			else
				flash[:notice] = "Your report meets incident!"
			end	
		end
		redirect_back(fallback_location: root_path)
	end

	private
	def find_post
		@post = Post.find(params[:post_id])
	end

	def report_params
		params.require(:report).permit(:reason)
	end

	def find_report(user)
		@post.reports.each do |report|
			if report.user_id == user.id
				return report
			end
		end
		nil
	end
end
