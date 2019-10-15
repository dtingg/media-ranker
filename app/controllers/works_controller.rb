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
end
