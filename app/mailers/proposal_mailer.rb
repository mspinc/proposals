class ProposalMailer < ApplicationMailer
  def proposal_submission
    proposal = params[:proposal]
    proposal_pdf = params[:file]
    email = params[:email]

    attachments["#{proposal.title}.pdf"] = proposal_pdf

    mail(to: email, subject: "BIRS Proposal: #{proposal.title}")
  end
end
