class ListsController < ApplicationController
  
  before_action :permitted_list, on: [:show]

  def index
    #@garbage = current_user.lists.all      
  end
  
  def show
    @list = List.includes(:items).find(params[:id])
  end
  
  def new
    @list = List.new
    1.times { @list.items.build }
  end
  
  def create
    @list = List.create(list_params)
        
    if @list.save
      redirect_to user_path(current_user), notice: "#{@list.list_name.capitalize} was created!"
    else
      1.times{ @list.items.build }
      flash.now.alert = "Your list must have a name"
      render :edit
    end
    
  end
  
  def edit
    @list = List.find(params[:id])
    1.times { @list.items.build }
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
    
    redirect_to user_path(current_user)
  end


  private
  def list_params
    params.require(:list).permit(:list_name, :notes, :user_id, items_attributes: [:id, :name, :quan, :notes, :_destroy])
  end
    
end
