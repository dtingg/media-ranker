class WorksController < ApplicationController
  def index
    @works = Work.order(:title)    
  end  
  
  def show
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def new
    @work = Work.new
  end
  
  def create
    if params[:work].nil?
      redirect_to new_work_path
      return
    end
    
    @work = Work.new(work_params)
    
    if @work.save
      redirect_to work_path(@work.id)
      return
      
    else
      render :new
      return
    end
  end
  
  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    end
  end
  
  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    elsif @work.update(work_params)
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    @work = Work.find_by(id: params[:id])
    
    @work.destroy if @work
    
    redirect_to root_path
  end
  
  def upvote
    
    binding.pry
    @current_user = User.find_by(id: session[:user_id])
    
    binding.pry
    if @current_user.nil?
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to root_path
      return
    end
    
    
    @work = Work.find_by(id: params[:id])
    
    binding.pry
    if Vote.where(work_id: @work.id, user_id: @current_user.id).empty?
      v = Vote.create(work_id: @work.id, user_id: @current_user.id)  
      
      binding.pry
      # redirect_back(fallback_location: work_path(work))
      # return
    else
      flash[:error] = "A problem occurred: Could not upvote. user: has already voted for this work"
      
      binding.pry
      # redirect_back(fallback_location: root_path)
    end
    binding.pry
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end  
end
