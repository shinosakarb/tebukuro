# frozen_string_literal: true

require 'rails_helper'

describe UserParticipant do
  describe 'method' do
    let(:user) { build_stubbed(:user) }
    let(:event) { build_stubbed(:event, id: 1, participants: [participant]) }
    let(:participant) { build_stubbed(:participant, event_id: 1, user: user) }


    describe '#registered?' do
      context 'with user signed in' do
        let(:user_participant) do
          UserParticipant.new(event: event, current_user: user)
        end

        context 'with user registered' do
          before do
            allow(Participant).to receive(:find_by).and_return(participant)
          end

          it 'returns true' do
            expect(user_participant.registered?).to be_truthy
          end
        end

        context 'with user not registered' do
          before do
            allow(Participant).to receive(:find_by).and_return(nil)
          end

          it 'returns false' do
            expect(user_participant.registered?).to be_falsey
          end
        end
      end

      context 'with user not signed in' do
        let(:user_participant) do
          UserParticipant.new(event: event, current_user: nil)
        end

        it 'returns false' do
          expect(user_participant.registered?).to be_falsey
        end
      end
    end

    describe '#on_waiting_list' do
      context 'with user signed in' do
        let(:user_participant) do
          UserParticipant.new(event: event, current_user: user)
        end

        context 'with user registered' do
          before do
            allow(Participant).to receive(:find_by).and_return(participant)
          end

          context 'on waitlisted' do
            before do
              allow(participant).to receive(:waitlisted?).and_return(true)
            end

            it 'returns true' do
              expect(user_participant.on_waiting_list?).to be_truthy
            end
          end

          context 'not on waitlisted' do
            before do
              allow(participant).to receive(:waitlisted?).and_return(false)
            end

            it 'returns false' do
              expect(user_participant.on_waiting_list?).to be_falsey
            end
          end
        end

        context 'with user not registered' do
          before do
            allow(Participant).to receive(:find_by).and_return(nil)
          end

          it 'returns false' do
            expect(user_participant.on_waiting_list?).to be_falsey
          end
        end
      end

      context 'with user not signed in' do
        let(:user_participant) do
          UserParticipant.new(event: event, current_user: nil)
        end

        it 'returns false' do
          expect(user_participant.on_waiting_list?).to be_falsey
        end
      end
    end
  end
end
