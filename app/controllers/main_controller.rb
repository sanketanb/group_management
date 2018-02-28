class MainController < ApplicationController
  # skip_before_action :require_login, except: [:destroy]
  # note to self: do require_login check for destroy method only.

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      if @user.try(:authenticate, params[:user][:password])
        session[:user_id] = @user.id
        redirect_to "/groups"
      else 
        flash[:errors] =["Please enter a valid password"]
        redirect_to '/main'
      end
    else
      flash[:errors] = ["Please enter a valid email"]
      redirect_to '/main'
    end
  end

  def destroy
    session[:user_id] = nil
    puts "from sessions destroy"
    redirect_to '/main'
  end

  private
  def login_params
    params.require(:user).permit(:email, :password)
  end
end
