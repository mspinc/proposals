require 'rails_helper'

RSpec.describe ProposalFields, type: :model do
  describe '#table_name' do
    it '' do 
      expect(described_class.table_name_prefix).to eq('proposal_fields_')
    end
  end
end
