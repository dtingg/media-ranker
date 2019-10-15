class WorksController < ApplicationController
  def index
    @works = Work.order(:title)    
  end  
end
