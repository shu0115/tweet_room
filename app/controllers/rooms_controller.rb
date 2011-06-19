class RoomsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @rooms = Room.paginate_by_args_option( { :user_id => session[:user_id] }, { :page => params[:page], :per_page => $per_page, :order => "created_at DESC", :include => "user" } )
  end

  #-----#
  # new #
  #-----#
  def new
    @room = Room.new
  end

  #--------#
  # create #
  #--------#
  def create
    @room = Room.new( params[:room] )
    @room.user_id = session[:user_id]
    @room.hash_tag = "" if @room.hash_tag == "#"

    unless @room.save
      flash[:notice] = "ルームの作成に失敗しました。"
    end

    redirect_to :action => "index" and return
  end

  #------#
  # show #
  #------#
  def show
    @room = Room.find_by_args_option( { :id => params[:id], :user_id => session[:user_id] }, { :include => "user" } )
    
    redirect_to :action => "index" and return if @room.blank?
  end

  #------#
  # edit #
  #------#
  def edit
    @room = Room.find_by_args( :id => params[:id], :user_id => session[:user_id] )
    
    redirect_to :action => "index" and return if @room.blank?
  end

  #--------#
  # update #
  #--------#
  def update
    @room = Room.find_by_args( :id => params[:id], :user_id => session[:user_id] )
    
    params[:room][:hash_tag] = "" if !params[:room].blank? and params[:room][:hash_tag] == "#"

    unless @room.update_attributes( params[:room] )
      flash[:notice] = "ルームの更新に失敗しました。"
    end

    redirect_to :action => "index" and return
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @room = Room.find_by_args( :id => params[:id], :user_id => session[:user_id] )
    
    unless @room.destroy
      flash[:notice] = "ルームの削除に失敗しました。"
    end

    redirect_to :action => "index" and return
  end

end
