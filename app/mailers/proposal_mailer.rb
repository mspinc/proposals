class ProposalMailer < ApplicationMailer
  def proposal_submission
    proposal = params[:proposal]
    proposal_pdf = params[:file]
    email = proposal.lead_organizer.email
    @organizer = proposal.lead_organizer.fullname
    @year = proposal.year
    @code = proposal.code

    attachments["#{proposal.code}-proposal.pdf"] = proposal_pdf

    mail(to: email, subject: "BIRS Proposal #{proposal.code}: #{proposal.title}")
  end
end
