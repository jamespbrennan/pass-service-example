class UsersController < ApplicationController
  def callback
    attributes = params.required(:user).permit(:id, :email)
    User.create(email: attributes[:email], pass_user_id: attributes[:id])

    render :nothing => true
  end
end
