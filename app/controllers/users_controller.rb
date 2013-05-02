class UsersController < ApplicationController
  def callback
    params.required(:email)
    params.required(:user_id)
    User.create(email: params[:email], pass_user_id: params[:user_id])

    render :nothing => true
  end
end
