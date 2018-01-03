# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :participant do
    sequence(:id)
    sequence(:name) { |n| "参加者 #{n}" }
  end
end
