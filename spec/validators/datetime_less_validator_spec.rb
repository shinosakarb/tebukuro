require 'rails_helper'

shared_context 'less_than_or_equal_to' do
  let(:start_at) { Time.now }

  subject { dummy_class.new(start_at, end_at) }

  context 'less than' do
    let(:end_at) { Time.now.tomorrow }
    it { is_expected.to be_valid }
  end

  context 'equal to' do
    let(:end_at) { start_at }
    it { is_expected.to be_valid }
  end

  context 'greater than' do
    let(:end_at) { start_at.yesterday }

    example do
      is_expected.to be_invalid
      expect(subject.errors.messages).to include(
        start_at: ['はEnd atより前の日時にしてください']
      )
    end
  end
end

shared_context 'greater_than_or_equal_to' do
  let(:start_at) { Time.now }

  subject { dummy_class.new(start_at, end_at) }

  context 'less than' do
    let(:end_at) { Time.now.yesterday }
    example do
      is_expected.to be_invalid
      expect(subject.errors.messages).to include(
        end_at: ['はStart atより後の日時にしてください']
      )
    end
  end

  context 'equal to' do
    let(:end_at) { start_at }
    it { is_expected.to be_valid }
  end

  context 'greater than' do
    let(:end_at) { start_at.tomorrow }
    it { is_expected.to be_valid }
  end
end

shared_context 'multiple options' do
  let(:start_at) { Time.now }
  let(:end_at)   { start_at.tomorrow }

  subject { dummy_class.new(start_at, end_at, checked_at) }

  context 'valid' do
    let(:checked_at) { start_at }
    it { is_expected.to be_valid }
  end

  context 'less than' do
    let(:checked_at) { start_at.yesterday }

    example do
      is_expected.to be_invalid
      expect(subject.errors.messages).to include(
        checked_at: ['はStart atより後の日時にしてください']
      )
    end
  end

  context 'greater than' do
    let(:checked_at) { end_at.tomorrow }

    example do
      is_expected.to be_invalid
      expect(subject.errors.messages).to include(
        checked_at: ['はEnd atより前の日時にしてください']
      )
    end
  end
end

describe DatetimeLessValidator do
  let(:dummy_class) do
    Struct.new(:start_at, :end_at) do
      include ActiveModel::Validations

      validates :start_at, datetime_less: { less_than_or_equal_to: :end_at }

      def self.name
        'Dummy'
      end
    end
  end

  describe 'less_than_or_equal_to' do
    include_context 'less_than_or_equal_to'
  end

  describe 'greater_than_or_equal_to' do
    let(:dummy_class) do
      Struct.new(:start_at, :end_at) do
        include ActiveModel::Validations

        validates :end_at, datetime_less: { greater_than_or_equal_to: :start_at }

        def self.name
          'Dummy'
        end
      end
    end

    include_context 'greater_than_or_equal_to'
  end

  describe 'multiple options' do
    let(:dummy_class) do
      Struct.new(:start_at, :end_at, :checked_at) do
        include ActiveModel::Validations

        validates :checked_at, 
          datetime_less: {
            less_than_or_equal_to:    :end_at,
            greater_than_or_equal_to: :start_at 
          }

        def self.name
          'Dummy'
        end
      end
    end

    include_context 'multiple options'
  end

  describe 'type error' do
    subject { dummy_class.new }

    example do
      is_expected.to be_invalid
      expect(subject.errors.messages).to include(
        start_at: ['は日時で入力してください']
      )
    end
  end

  describe 'target blank' do
    let(:start_at) { Time.now }

    subject { dummy_class.new(start_at) }

    example do
      is_expected.to be_invalid
      expect(subject.errors.messages).to include(
        start_at: ['End atを入力してください']
      )
    end
  end

  describe 'helper method' do
    let(:dummy_class) do
      Struct.new(:start_at, :end_at) do
        include ActiveModel::Validations

        validates_datetime_less_of :start_at, less_than_or_equal_to: :end_at

        def self.name
          'Dummy'
        end
      end
    end

    include_context 'less_than_or_equal_to'
  end
end
