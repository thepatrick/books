class UserSessionController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :login_with_token]
  before_filter :require_user, :only => :destroy
  
  def login_with_token
    unless consumer and params[:token]
      redirect_to '/' and return
    end
    token = consumer.retrieve_details params[:token]
    if token.nil?
      throw "Invalid token"
    end
    user = User.where(:patrick_id => token['user']['id']).first
    if user.nil? and token['user']['administrator']
      gen_pwd = Authlogic::Random.friendly_token + Authlogic::Random.friendly_token 
      user = User.create :patrick_id => token['user']['id'], :login => token['user']['name'], :password => gen_pwd, :password_confirmation => gen_pwd
    end
    if user.nil?
      render :text => "Unauthorized"
      return
    end
    # render :json => { :token => consumer.retrieve_details(params[:token]), :user => user }
    @user_session = UserSession.new(user)
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default books_url
    else
      render :text => "Unauthorized, couldn't save"
    end
  end
  
  
  def new
    if consumer
      redirect_to consumer.login_url(login_with_token_path)
      return
    end
    @user_session = UserSession.new
  end
 
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default books_url
    else
      render :action => :new
    end
  end
 
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end
end
