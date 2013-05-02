class UsersController < ApplicationController
  def callback
    params.required(:email)
    params.required(:id)
    User.create(email: params[:email], pass_user_id: params[:id])

    render :nothing => true
  end
end
