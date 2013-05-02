class SessionsController < ApplicationController
  def new
    redirect_to controller: 'secret', action: 'index', protocol: 'https://' unless current_user.nil?

    begin
      pass_session = Pass::Session.create
    rescue Pass::PassError => e
      logger.error e.to_s
      render text: 'Pass API Error!'
    end

    session[:pass_session_id] = pass_session.id

    @pass_session_id = pass_session.id
  end

  def destroy
    session[:pass_user_id] = nil
    redirect_to controller: 'secret', action: 'index', protocol: 'https://'
  end

  def callback
    params.required('session_id')

    begin
      pass_session = Pass::Session.retrieve params[:session_id].to_s

      if pass_session.is_authenticated && pass_session.user
        session = ActiveRecord::SessionStore::Session.find_by_pass_session_id(pass_session.id)
        session.set_attribute!("pass_user_id", pass_session.user.id)
        session.save
      else
        logger.error 'Receieved a unauthenticated session.'
        logger.error pass_session.to_s
      end
    rescue Pass::PassError => e
      logger.error e.to_s
      render text: 'Pass Error!'
      return
    end

    render :nothing => true
  end
end
