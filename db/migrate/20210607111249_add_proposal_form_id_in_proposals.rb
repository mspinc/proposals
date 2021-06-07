class AddProposalFormIdInProposals < ActiveRecord::Migration[6.1]
  def change
    add_reference :proposals, :proposal_form, null: false, foreign_key: true
  end
end
