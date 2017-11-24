require 'rails_helper'

RSpec.describe Participant, type: :model do

  describe 'association' do
    it { is_expected.to belong_to(:event) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

end
