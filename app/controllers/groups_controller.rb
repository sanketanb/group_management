class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @display_group = Group.find_by_id(params[:id])
  end

  def create
    @group = Group.new(group_params)

    if @group.valid?
      @group.user = User.find_by_id(session[:user_id])
      @group.user = current_user
      # puts "current user is #{current_user}"
      # puts "session user is #{session[:user_id]}"
      @group.save

      member = Member.new
      member.user = current_user
      member.group = @group
      member.save
      redirect_to '/groups'
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to '/groups'
    end
  end

  def destroy
    group = Group.find_by_id(params[:id])
    group.destroy
    # puts "destroyed group id is: #{params[:id]}"
    redirect_to "/groups"
  end 

  private
  def group_params
    params.require(:group).permit(:name, :description)
  end

end
