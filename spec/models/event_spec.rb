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
    describe '#admitted_participant?' do
      let(:quota) { 3 }
      let(:event) { build_stubbed(:event, quota: quota) }

      subject { event.admitted_participant?(event.participants.last.id) }

      context "with admitted participant's id" do
        before do
          event.participants.build(attributes_for_list(:participant, quota))
        end

        it { is_expected.to eq(true) }
      end

      context "with not admitted participant's id" do
        before do
          event.participants.build(attributes_for_list(:participant, quota + 1))
        end

        it { is_expected.to eq(false) }
      end
    end
  end
end
