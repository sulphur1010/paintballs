class Invitemailer < ApplicationMailer
	default from: "invite@bushfighterpaintball.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitemailer.candidate_invite.subject
  #
  # def candidate_invite
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end

  def member_invite_to_team(inviter, team, email)
    @team = team
    @user = inviter
    @team_img = @team.logo
    mail(to: email, subject: "#{@team.name} Team Invitation")
  end
end
