class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      puts "User is: #{@user}"

      session[:user_id] = @user.id
      puts "session id is #{session[:user_id]}"
      
      redirect_to '/groups'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/main'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
