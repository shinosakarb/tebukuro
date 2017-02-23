require 'rails_helper'

describe Ticket do
  describe 'association' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to have_one(:community).through(:event) }
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cost) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:sale_starts_at) }
    it { is_expected.to validate_presence_of(:sale_ends_at) }
  end

  describe 'numericality' do
    it { is_expected.to validate_numericality_of(:cost).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  end
end
