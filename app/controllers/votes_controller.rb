class VotesController < ApplicationController
  def upvote
    @current_user = User.find_by(id: session[:user_id])
    
    if @current_user.nil?
      flash[:warning] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: root_path)
      return
    end
    
    @work = Work.find_by(id: params[:work_id])
    
    if !Vote.where(work_id: @work.id, user_id: @current_user.id).empty?
      flash[:warning] = "A problem occurred: Could not upvote."
      flash[:other] = "user: has already voted for this work"
      
      redirect_back(fallback_location: root_path)
      return
    else
      Vote.create(work_id: @work.id, user_id: @current_user.id, created: Date.today)  
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
      return
    end
  end 
  
  private
  
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id, :created)    
  end
end
