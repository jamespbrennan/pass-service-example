class UsersController < ApplicationController
  def callback
    params.required(:id)
    params.required(:email)
    User.create(email: params[:id], pass_user_id: params[:email])

    render :nothing => true
  end
end
