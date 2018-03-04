# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :participant do
    sequence(:name) { |n| "参加者 #{n}" }
    user nil
  end
end
