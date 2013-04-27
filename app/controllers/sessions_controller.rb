class SessionsController < ApplicationController
  def new
    begin
      pass_session = Pass::Session.create
    rescue Pass::APIError
      # Deal with it!
    end

    @pass_session_id = pass_session.id
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def callback
    params.required('id')

    pass_session = Pass::Session.retreieve params[:id]

    if pass_session.is_authenticated && pass_session.user
      session[:user_id] = pass_session.user.id
    end
  end
end