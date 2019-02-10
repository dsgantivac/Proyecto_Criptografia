class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #skip_before_action :authorize, only: [:new,:created,:index]
  #function to validate email
  def is_a_valid_email?(email)
    email_regex = %r{
      ^ # Start of string
      [0-9a-z] # First character
      [0-9a-z.+]+ # Middle characters
      [0-9a-z] # Last character
      @ # Separating @ character
      [0-9a-z] # Domain name begin
      [0-9a-z.-]+ # Domain name middle
      [0-9a-z] # Domain name end
      $ # End of string
    }xi # Case insensitive

    (email =~ email_regex)
  end
  
  def is_a_valid_pass?(ṕass)
    pass_regex = %r{
      ^ # Start of string
      (?=.*[a-zA-Z])(?=.*[0-9]).{8,}
      $ # End of string
    }

    (pass =~ pass_regex)
  end
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.pin = (0...8).map { (65 + rand(26)).chr }.join

     
    #raise params.to_yaml
      respond_to do |format|
        if @user.save && @user.password == @user.conf_password
          if(is_a_valid_email?(@user.email))
            if(is_a_valid_pass?(@user.password))
              session[:user_id] = @user.id
              format.html { redirect_to '/articles', notice: 'User was successfully created and logging Succesfully' }
              format.json { render :show, status: :created, location: @user }
            else
              format.html { redirect_to '/users/new'}
              flash[:notice] = 'Password must contain at least a lowercase letter, a uppercase, a digit and 8+ chars'
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          else
            format.html { redirect_to '/users/new'}
            flash[:notice] = 'Invalid email'
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to '/users/new'}
          flash[:notice] = 'Passwords not match'
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :conf_password, :name)
    end
end
