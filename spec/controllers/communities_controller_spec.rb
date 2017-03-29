require 'rails_helper'

RSpec.describe CommunitiesController, type: :controller do
  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:authorize_community) }
end
