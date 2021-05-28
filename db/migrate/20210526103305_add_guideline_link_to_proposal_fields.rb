class AddGuidelineLinkToProposalFields < ActiveRecord::Migration[6.1]
  def change
    add_column :proposal_fields, :guideline_link, :string
  end
end
