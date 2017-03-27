require 'rails_helper'

describe Subscription::TicketsController, type: :controller do
  it { is_expected.to use_before_action(:authenticate_user!) }
end
