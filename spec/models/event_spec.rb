# frozen_string_literal: true

require 'rails_helper'

describe Event, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:participants) }
  end

  describe 'validation' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe '#quota' do
      it {
        is_expected.to validate_numericality_of(:quota)
          .is_greater_than_or_equal_to(1)
          .is_less_than_or_equal_to(1000)
      }
    end
  end

  describe 'method' do
    describe '#admitted_participant_ids' do
      subject { event.admitted_participant_ids }

      context 'with valid quota' do
        let(:quota) { 3 }
        let(:event) {
          build_stubbed(:event, quota: quota, participants: participants)
        }
        let(:participants) {
          [*1..(quota + 1)].map { |i| build(:participant, id: i) }
        }
        let(:admitted_participants) { [*1..quota] }

        it { is_expected.to eq(admitted_participants) }

        it 'caches admitted_participant_ids as an instance variable' do
          subject
          expect(event.instance_variable_get('@admitted_participant_ids'))
            .to eq(admitted_participants)
        end
      end

      context 'with invalid quota' do
        let(:event) { build(:event, quota: nil) }
        it { is_expected.to eq([]) }
      end
    end
  end
end
