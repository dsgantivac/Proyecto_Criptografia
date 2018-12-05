require "Algorithms/rsa.rb"
require "welcome_controller.rb"
class SessionsController < ApplicationController
  #skip_before_action :authorize

  def create
    user = User.find_by(email: params[:email])
   # @d = inv_mod(3,3220)
    print("aiuda:",$gd, "\n")
    print("aiuda2:",$gn, "\n")

    @arr = params[:cipherPass].split(",")
    print("el arreglo:", @arr,"\n")
    @decipher = decryptRsa(@arr,$gd,$gn)
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

  def new
    @keyaux = generate_keys()
    @auxd=@keyaux[1]
    @auxn=@keyaux[2]
    @key1=@keyaux[0]
    @key2=@keyaux[2]
    $gd=@keyaux[1]
    $gn=@keyaux[2]
    $phic =@keyaux[3]
    print("aiudad:",$gd, "\n")
    print("aiudan:",$gn, "\n")
    print("aiudae:",@key1, "\n")
    print("phic:",$phic, "\n")



  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end


end
