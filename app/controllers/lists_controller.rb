class ListsController < ApplicationController
  
  def index
    @lists = List.all
  end
  
  def show
    @list = List.includes(:items).find(params[:id])
  end
  
  def new
    @list = List.new
    3.times { @list.items.build }
  end
  
  def create
    @list = List.create(list_params)
    redirect_to @list
  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id])
    redirect_to @list, notice: "List Updated!" if @list.update(list_params)
  end
    
  private
  def list_params
    params.require(:list).permit(:list_name, :notes, items_attributes: [:id, :name, :quan, :notes, :_destroy])
  end
    
end
