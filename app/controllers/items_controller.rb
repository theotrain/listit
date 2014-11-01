class ItemsController < ApplicationController
  before_action :require_user
  before_action :set_item, only: [:activate, :update, :edit]
  before_action :require_item_creator, only: [:activate, :edit, :update]

  def new
    @item = Item.new
  end

  def create
    # binding.pry
    params[:checkbox][:checked] == '1' ? save_time = params[:sms_time].to_datetime.change(offset: decimal_to_time_zone(params[:zone_offset])) : save_time = nil
    @item = Item.new(user: current_user, active: true, body: params[:item][:body], 
      sms_time: save_time, sms_sent: false, position: current_user.items.count+1, time_zone_offset: params[:zone_offset])
  
    if @item.save
      flash[:notice] = "New To-Do Item Added."
      redirect_to list_user_path(@item.user)
    else
      render :new
    end
  end

  def edit
    #  params[:checkbox][:checked] == '1' save date only if checked as in create
    # params[:date_changed] == true   ---> date was changed and needs to be saved.
  end

  def update
    # binding.pry
    # first update the safe parts 
    if params[:checkbox][:checked] == '0' 
      update_hash = {body: params[:item][:body], sms_time: nil}
    elsif params[:date_changed]
      update_hash = {body: params[:item][:body], sms_time: params[:sms_time].to_datetime.change(offset: decimal_to_time_zone(params[:zone_offset])), time_zone_offset: params[:zone_offset], sms_sent: false}
    end
    if @item.update(update_hash)
      flash[:notice] = "To-Do Item Updated."
      redirect_to list_user_path(@item.user)
    else
      render :edit
    end

  end

  def activate
    # //toggle active status
    
    if @item.update(active: !@item.active)
      # flash[:notice]='updating'
    end

    
    # respond_to do |format|
    #   format.html do
    #     flash[:notice] = 'Why are you here?'
    #     redirect_to :back
    #   end
    #   format.js { }
    # end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end