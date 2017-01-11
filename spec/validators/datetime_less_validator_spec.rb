require 'rails_helper'

shared_examples "validate before option" do  
  describe 'start_at' do
    let(:base_datetime) { Time.current }

    subject { dummy_class.new(start_at, end_at) }

    context 'less than end_at' do
      let(:start_at) { base_datetime }
      let(:end_at)   { base_datetime.tomorrow }

      it { is_expected.to be_valid }
    end

    context 'equal to end_at' do
      let(:start_at) { base_datetime }
      let(:end_at)   { base_datetime }

      it { is_expected.to be_valid }
    end

    context 'greater than end_at' do
      let(:start_at) { base_datetime }
      let(:end_at)   { base_datetime.yesterday }

      example do
        is_expected.not_to be_valid
        expect(subject.errors.messages).to include(
          start_at: ['must be before End at']
        )
      end
    end

    context 'target nil' do
      let(:start_at) { base_datetime }
      let(:end_at)   { nil }

      example do
        is_expected.not_to be_valid
        expect(subject.errors.messages).to include(
          start_at: ['must not be nil End at']
        )
      end
    end
  end
end

describe DatetimeLessValidator do
  describe 'option' do
    let(:dummy_class) do
      Struct.new(:start_at, :end_at) do
        include ActiveModel::Validations

        validates :start_at,
          datetime_less: {
            before: :end_at
          }

        def self.name
          'Dummy'
        end
      end
    end

    include_examples "validate before option"
  end

  describe 'helper method' do
    let(:dummy_class) do
      Struct.new(:start_at, :end_at) do
        include ActiveModel::Validations

        validates_datetime_less_of :start_at, before: :end_at, presence: true

        def self.name
          'Dummy'
        end
      end
    end

    include_examples "validate before option"
  end
end
