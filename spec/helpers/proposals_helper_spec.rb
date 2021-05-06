require 'rails_helper'

RSpec.describe ProposalsHelper, type: :helper do
  describe "#proposal_types" do
    let(:location) { create(:location) }
    let(:proposal_type) { create(:proposal_type, locations: [location]) }
    let(:published_form) { create(:proposal_form, proposal_type: proposal_type, status: :active) }
    let(:proposal_type1) { create(:proposal_type, locations: [location]) }
    let(:draft_form) { create(:proposal_form, proposal_type: proposal_type1, status: :draft) }

    it "returns proposal types [name,id] if it has publish form" do
      published_form
      expect(proposal_types).to eq([[proposal_type.name, proposal_type.id]])
    end

    it "returns no proposal types [name,id] if not has publish form" do
      draft_form
      expect(proposal_types).to eq([])
    end
  end

  describe "#locations" do
    let(:locations_list) { create_list(:location, 4) }
    it "returns array of locations [name,id]" do
      locations_list
      expect(locations).to match_array(locations_list.pluck(:name, :id))
    end
  end
end
