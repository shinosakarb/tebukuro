module TokenAuth
  def mock_current_user_with(user)
    allow_any_instance_of(DeviseTokenAuth::Controllers::Helpers).to receive(:current_user).and_return(user)
  end
end
