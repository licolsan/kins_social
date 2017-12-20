class UsersController < ApplicationController
  before_action :create_activation_digest, only:[:create]

  def new
  	@user = User.new
  end

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(activated: true)
      user.update_attribute(activate_at, Time.zone.now)
      session[:user_id] = user.id
      flash[:notice] = "Account activated!"
      redirect_to root_url
    else
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		# session[:user_id] = @user.id
  		# redirect_to root_url, notice: "Signed in"
      UserMailer.account_activation(@user).deliver_now
      flash[:notice] = "PLease check your email to activate your account"
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def downcase_email
    self.email = email.donwcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
