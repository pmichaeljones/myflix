class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.create(invite_params)
    invitation.update_column(:inviter_id, current_user.id)
    AppMailer.send_invitation_email(invitation).deliver
    flash[:info] = "Invitation delivered."
    redirect_to new_invitation_path
  end


  private

  def invite_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
  end


end
