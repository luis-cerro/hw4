class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome back, #{@user["username"]}!"
        redirect_to "/places"
      else
        flash["notice"] = "Wrong login credentials."
        redirect_to "/login"
      end
    else
      flash["notice"] = "You do not have an account. Please, create one."
      redirect_to "/login"
    end
  end

  def destroy
    flash["notice"] = "You are being logged out."
    session["user_id"] = nil
    redirect_to "/login"
  end
end
  