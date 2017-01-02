require 'test_helper'

class InvitemailerTest < ActionMailer::TestCase
  test "candidate_invite" do
    mail = Invitemailer.candidate_invite
    assert_equal "Candidate invite", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
