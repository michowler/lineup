class UserMailer < ApplicationMailer
  def change_password(user)
    @user = user
    email = @user.email
    mail(
      from: Clearance.configuration.mailer_sender,
      to: email,
      subject: 'LineUP: Change Password'
    )
  end

  def create_user(user,password)
    @user = user
    @password = password
    mail(
      from: Clearance.configuration.mailer_sender,
      to: @user.email,
      subject: 'LineUP: Account created'
    )
  end
end
