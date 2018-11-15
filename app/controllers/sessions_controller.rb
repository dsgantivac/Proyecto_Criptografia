require "Algorithms/rsa.rb"
require "welcome_controller.rb"
class SessionsController < ApplicationController
  #skip_before_action :authorize

  def create
    user = User.find_by(email: params[:email])
    @d = inv_mod(3,3220)
    @arr = params[:cipherPass].split(",")
    @decipher = decryptRsa(@arr,@d,3337)
    if user && user.password == params[:password]
      if @decipher == params[:password]
        session[:user_id] = user.id
        redirect_to root_url, notice: "Logged in!"
      else
        flash.now.alert = "Login is not permitted"
      end
    else
      redirect_to root_url, notice: "Email or password is invalid."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end


end
