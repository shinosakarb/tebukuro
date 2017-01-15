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
          start_at: ["End at can't be blank"]
        )
      end
    end
  end
end

shared_examples "validate after option" do
  describe 'end_at' do
    let(:base_datetime) { Time.current }

    subject { dummy_class.new(start_at, end_at) }

    context 'greater than start_at' do
      let(:start_at) { base_datetime }
      let(:end_at)   { base_datetime.tomorrow }

      it { is_expected.to be_valid }
    end

    context 'equal to start_at' do
      let(:start_at) { base_datetime }
      let(:end_at)   { base_datetime }

      it { is_expected.to be_valid }
    end

    context 'less than start_at' do
      let(:start_at) { base_datetime }
      let(:end_at)   { base_datetime.yesterday }

      example do
        is_expected.not_to be_valid
        expect(subject.errors.messages).to include(
          end_at: ['must be after Start at']
        )
      end
    end

    context 'target nil' do
      let(:start_at) { nil }
      let(:end_at)   { base_datetime }

      example do
        is_expected.not_to be_valid
        expect(subject.errors.messages).to include(
          end_at: ["Start at can't be blank"]
        )
      end
    end
  end
end

shared_examples "ArgumentError example" do |message|
  subject { dummy_class.new(start_at, end_at) }

  example do 
    expect { subject.vaid? }.to raise_error(ArgumentError, message)
  end
end

describe DatetimeLessValidator do
  describe 'option' do
    context 'before' do
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

    context 'after' do
      let(:dummy_class) do
        Struct.new(:start_at, :end_at) do
          include ActiveModel::Validations

          validates :end_at,
            datetime_less: {
              after: :start_at
            }

          def self.name
            'Dummy'
          end
        end
      end

      include_examples "validate after option"
    end

    context 'argument error' do
      context 'option not exists' do
        let(:dummy_class) do
          Struct.new(:start_at, :end_at) do
            include ActiveModel::Validations

            validates :end_at,
              datetime_less: {
              }

            def self.name
              'Dummy'
            end
          end
        end

        include_examples 'ArgumentError example', /Requires :before or :after optio/
      end

      context 'dupulicate option' do
        let(:dummy_class) do
          Struct.new(:start_at, :end_at) do
            include ActiveModel::Validations

            validates :end_at,
              datetime_less: {
                before: :start_at,
                after:  :start_at
              }

            def self.name
              'Dummy'
            end
          end
        end

        include_examples 'ArgumentError example', /Duplicate option of :before and :afte/
      end
    end
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
