class SessionsController < ApplicationController
  def new
    begin
      pass_session = Pass::Session.create
    rescue Pass::PassError
      render text: 'Pass API Error!'
    end

    session[:pass_session_id] = pass_session.id

    @pass_session_id = pass_session.id
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

  def callback
    params.required('session_id')

    begin
      pass_session = Pass::Session.retrieve params[:session_id]

      if pass_session.is_authenticated && pass_session.user
        session = ActiveRecord::SessionStore::Session.find_by_pass_session_id(pass_session.id)
        session.set_attribute!("user_id", pass_session.user_id)
        session.save
      end
    rescue Pass::PassError
      render text: 'Pass Error!'
      return
    end

    render :nothing => true
  end
end
