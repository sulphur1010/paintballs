# Preview all emails at http://localhost:3000/rails/mailers/invitemailer
class InvitemailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invitemailer/candidate_invite
  def candidate_invite
    Invitemailer.candidate_invite
  end

end
