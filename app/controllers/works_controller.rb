class WorksController < ApplicationController
  def index
    # https://stackoverflow.com/questions/16996618/rails-order-by-results-count-of-has-many-association
    # @works = Work.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC'))
    @works = Work.sort_by_votes
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
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"  
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
    flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"    
    redirect_to root_path
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end  
end
