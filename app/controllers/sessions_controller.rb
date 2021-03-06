class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create_with_omniauth(auth)
    user.repositories.destroy_all
    user.save_repositories!
    session[:user_id] = user.id
    redirect_to welcome_index_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
