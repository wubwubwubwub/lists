class ListsController < ApplicationController
  
  def index
    @lists = List.all
  end
  
  def show
    @list = List.includes(:items).find(params[:id])
  end
  
  def new
    @list = List.new
    10.times { @list.items.build }
  end
  
  def create
    @list = List.create(list_params)
    redirect_to @list
  end
  
  def edit
    @list = List.find(params[:id])
    10.times { @list.items.build }
  end
  
  def update
    @list = List.find(params[:id])
        
    if params[:commit] == "Email List!"
      SendList.quick_send(@list, params[:send_to_address], params[:sender]).deliver
      redirect_to @list, notice: "Email was sent to #{params[:send_to_address]}"
    elsif @list.update(list_params)
      redirect_to @list, notice: "List Updated!"
    else
      render 'form'
    end
      
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    
    redirect_to root_path
  end


  private
  def list_params
    params.require(:list).permit(:list_name, :notes, items_attributes: [:id, :name, :quan, :notes, :_destroy])
  end
    
end
