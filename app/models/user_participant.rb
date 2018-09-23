class UserParticipant
  def initialize(params)
    @event = params[:event]
    @user = params[:current_user]
  end

  def registered?
    user_participant.present?
  end

  def on_waiting_list?
    user_participant.try(:waitlisted?) || false
  end

  private

  def user_participant
    @user_participant ||= Participant.find_by(event: @event, user: @user)
  end
end
