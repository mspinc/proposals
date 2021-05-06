require 'rails_helper'

RSpec.describe ProposalFieldsHelper, type: :helper do
  describe "#proposal_type_locations" do
    let(:locations) { create_list(:location, 2) }
    let(:proposal_type) { create(:proposal_type, locations: locations) }

    it "returns locations of a proposal type" do
      expect(proposal_type_locations(proposal_type)).to match_array(proposal_type.locations.pluck(:name, :id))
    end
  end

  describe "#proposal_field_options" do
    let(:radio_field) { create(:proposal_field, :radio_field) }

    it "returns array of options value and text" do
      expect(proposal_field_options(radio_field.fieldable)).to match_array([%w[Female F], %w[Male M]])
    end

    it 'returns empty array' do
      radio_field.fieldable.update(options: '{}')
      expect(proposal_field_options(radio_field.fieldable)).to match_array([])
    end
  end

  describe "#options_for_field" do
    let(:single_choice_field) { create(:proposal_field, :single_choice_field) }

    it 'returns array of option values' do
      expect(options_for_field(single_choice_field)).to match_array(%w[Female Male])
    end

    it 'returns empty array' do
      single_choice_field.fieldable.update(options: '{}')
      expect(options_for_field(single_choice_field)).to match_array([])
    end
  end
end
