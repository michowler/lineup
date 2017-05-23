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
end
