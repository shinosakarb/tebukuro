class Attendance
  include ActiveModel::Model

  def initialize(params = {})
    @participant = params[:participant]
  end

  def update
    @participant.toggle_status
  end

  def event
    @participant.event
  end
end
