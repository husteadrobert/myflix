class InvitationsController < ApplicationController
  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invite_params.merge!(inviter_id: current_user.id))
    if @invitation.save
      AppMailer.delay.send_invitation(@invitation)
      flash[:success] = "You have successfully invited #{@invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash[:error] = "There was a problem"
      render :new
    end
  end

  private
    def invite_params
      params.require(:invitation).permit!
    end

end