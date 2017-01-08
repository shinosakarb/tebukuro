require 'rails_helper'

describe DateTimeDiffValidator do
  let(:dummy_class) do
    Class.new do
      include ActiveModel::Validations

      attr_reader :start_at, :end_at

      validates_with DateTimeDiffValidator,
        start_attr: :start_at,
        end_attr:   :end_at
    end
  end

  describe 'start_at' do
    subject { dummy_class.new }

    let(:base_datetime) { Time.current }

    context 'less than end_at' do
      before do
        allow(subject).to receive(:start_at).and_return(base_datetime)
        allow(subject).to receive(:end_at).and_return(base_datetime.tomorrow)
      end

      it { is_expected.to be_valid }
    end

    context 'equal to end_at' do
      before do
        allow(subject).to receive(:start_at).and_return(base_datetime)
        allow(subject).to receive(:end_at).and_return(base_datetime)
      end

      it { is_expected.to be_valid }
    end

    context 'greater than end_at' do
      before do
        allow(subject).to receive(:start_at).and_return(base_datetime)
        allow(subject).to receive(:end_at).and_return(base_datetime.yesterday)
      end

      it { is_expected.not_to be_valid }
    end
  end
end
