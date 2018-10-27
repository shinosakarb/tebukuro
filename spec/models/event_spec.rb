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

    describe '#organizer' do
      it { is_expected.to validate_presence_of(:organizer) }
    end

    describe '#quota' do
      it {
        is_expected.to validate_numericality_of(:quota)
          .is_greater_than_or_equal_to(1)
          .is_less_than_or_equal_to(1000)
      }
    end

    describe '#event_starts_at' do
      it { is_expected.to validate_presence_of(:event_starts_at) }
      it {
        is_expected.to validate_datetime_less_of(:event_starts_at)
          .is_less_than_or_equal_to(:event_ends_at)
      }
    end

    describe '#event_ends_at' do
      it { is_expected.to validate_presence_of(:event_ends_at) }
      it {
        is_expected.to validate_datetime_less_of(:event_ends_at)
          .is_greater_than_or_equal_to(:event_starts_at)
      }
    end
  end

  describe 'method' do
    describe '#waitlisted_participant_ids' do
      subject { event.waitlisted_participant_ids }

      context 'with valid quota' do
        let(:quota) { 3 }
        let(:event) do
          build_stubbed(:event, quota: quota, participants: participants)
        end

        context 'with waitlisted participant' do
          let(:participants) do
            [*1..(quota + 1)].map { |i| build(:participant, id: i) }
          end
          let(:waitlisted_participants) { [quota + 1] }

          it { is_expected.to eq(waitlisted_participants) }

          it 'caches waitlisted_participant_ids as an instance variable' do
            subject
            expect(event.instance_variable_get('@waitlisted_participant_ids'))
              .to eq(waitlisted_participants)
          end
        end

        context 'with no waitlisted participant' do
          let(:participants) do
            [*1..(quota - 1)].map { |i| build(:participant, id: i) }
          end

          it { is_expected.to eq([]) }
        end
      end

      context 'with invalid quota' do
        let(:event) { build(:event, quota: nil) }
        it { is_expected.to eq([]) }
      end
    end

    describe '#user_registered?' do
      let(:user) { build_stubbed(:user) }
      let(:event) { build_stubbed(:event) }

      context 'when user logged in' do
        subject { event.user_registered?(user) }

        context 'with registered user' do
          before do
            event.participants.build(
              attributes_for(:participant, event: event, user: user)
            )
          end
          it { is_expected.to eq(true) }
        end

        context 'with NOT registered user' do
          it { is_expected.to eq(false) }
        end
      end

      context 'when user NOT logged in' do
        subject { event.user_registered?(nil) }

        it { is_expected.to eq(false) }
      end
    end

    describe '#within_deadline?' do
      let(:start_date) { Time.zone.parse('2018-03-01T09:00:00Z') }
      let(:event) { build_stubbed(:event, event_starts_at: start_date) }
      subject { event.within_deadline? }

      before { allow(Time).to receive(:current).and_return(current_date) }

      context 'with date whithin the deadline' do
        let(:current_date) { Time.zone.parse('2018-03-01T08:59:59Z') }
        it { is_expected.to be_truthy }
      end

      context 'with date over the deadline' do
        let(:current_date) { Time.zone.parse('2018-03-01T09:00:00Z') }
        it { is_expected.to be_falsey }
      end
    end
  end
end
