class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_problem(user)
    @user = user
    mail to: @user.email, subject: "[Kins app] Account have problem"
  end
end
