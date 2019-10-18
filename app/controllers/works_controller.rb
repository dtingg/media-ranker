class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  
  def index
    @works = Work.sort_by_votes
  end  
  
  def show
    if @work.nil?
      redirect_to works_path
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
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"  
      
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "A problem occurred: Could not create album"
      
      render :new
      return
    end
  end
  
  def edit
    if @work.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    old_work_category = @work.category
    
    if @work.nil?
      redirect_to works_path
      return
      
    elsif @work.update(work_params)
      flash[:success] = "Successfully updated #{old_work_category} #{@work.id}"  
      redirect_to work_path
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    if !@work
      redirect_to root_path
    else
      @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"    
      redirect_to root_path
    end
  end
  
  private
  
  def find_work
    @work = Work.find_by(id: params[:id])
  end
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end  
end
