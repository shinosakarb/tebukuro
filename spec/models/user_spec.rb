# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'method' do
    let(:user) { build(:user, id: 1) }

    describe '#organizer?' do
      context 'organizer of event' do
        let(:event) { build_stubbed(:event, organizer_id: user.id) }

        it 'returns false' do
          expect(user.organizer?(event)).to be_truthy
        end
      end

      context 'not organizer of event' do
        let(:event) { build_stubbed(:event, organizer_id: 2) }

        it 'returns false' do
          expect(user.organizer?(event)).to be_falsey
        end
      end
    end
  end
end
