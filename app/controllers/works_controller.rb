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
    # TODO double check this
    # if params[:work].nil?
    #   redirect_to new_work_path
    #   return
    # end
    
    @work = Work.new(work_params)
    
    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      render :new
      return
    end
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end  
end
