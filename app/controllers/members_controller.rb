class MembersController < ApplicationController

  def create
      group = Group.find_by_id(params[:group_id])
      Member.create(user:current_user, group:group)
      redirect_to "/groups/#{params[:group_id]}"
  end

  def destroy
      group_d = Group.find_by_id(params[:group_id])
      member_d = Member.find_by(user:current_user, group:group_d)
      puts "destroyed member for: #{member_d}"
      member_d.destroy
      redirect_to "/groups/#{params[:group_id]}"
  end
end
