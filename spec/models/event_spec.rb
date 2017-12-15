require "rails_helper"

describe Event, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:participants) }
  end

  describe 'validation' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe '#quota' do
      it { is_expected.to validate_numericality_of(:quota).
           is_greater_than_or_equal_to(1).
           is_less_than_or_equal_to(1000).
           allow_nil }
    end
  end
end
