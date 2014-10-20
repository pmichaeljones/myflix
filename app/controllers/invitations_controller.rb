class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    #binding.pry
    @invitation = Invitation.create(invite_params)
    if @invitation.save
      @invitation.update_column(:inviter_id, current_user.id)
      AppMailer.delay.send_invitation_email(@invitation)#.deliver
      flash[:info] = "Invitation delivered to #{@invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash[:danger] = "Please fix these errors before sending your invitation."
      render :new
    end
  end


  private

  def invite_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
  end


end
