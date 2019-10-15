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
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end  
end