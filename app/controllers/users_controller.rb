class UsersController < ApplicationController
  def callback
    params.required(:id)
    params.required(:email)
    User.create(email: params[:email], pass_user_id: params[:id])

    render :nothing => true
  end
end
