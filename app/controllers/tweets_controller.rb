class TweetsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @room = Room.find_by_args( :id => params[:room_id] )
    @tweet = Tweet.new
    @tweets = Tweet.paginate_by_args_option( { :room_id => params[:room_id] }, { :page => params[:page], :per_page => $per_page, :order => "created_at DESC", :include => [ "room", "user" ] }  )
    redirect_to :controller => "rooms" and return if @room.blank?
    
    params[:tweet_page] = 1 if params[:tweet_page].blank? or params[:tweet_page].to_i <= 0
    params[:tweet_page] = ( 1500 / $per_page ) if !params[:tweet_page].blank? and params[:tweet_page].to_i >= ( 1500 / $per_page )
    search_param = Tweet.set_search_param( :q => @room.hash_tag, :rpp => $per_page, :page => params[:tweet_page] )
    @twitter_get = current_user.twitter.get( "http://search.twitter.com/search.json#{search_param}" )
  end
  
  #------#
  # post #
  #------#
  def post
    @room = Room.find_by_args( :id => params[:room_id] )
    redirect_to :action => "index" and return if @room.blank?

    @tweet = Tweet.new( params[:tweet] )
    @tweet.user_id = session[:user_id]
    @tweet.room_id = @room.id
    @tweet.post = "#{@tweet.post} #{@room.hash_tag}"

    # Twitter投稿
    if @room.synchro_flag == "ON"
      if current_user.twitter.post( '/statuses/update.json', :status => @tweet.post )
      #  if false
        flash[:tweet_notice] = "Twitterへの投稿に成功しました。"
      else
        flash[:tweet_notice] = "<span style=\"color: red;\">Twitterへの投稿に失敗しました。</span>"
      end
    end
    
    # DB保存
    if @room.keep_flag == "ON"
      unless @tweet.save
        flash[:tweet_notice] = "Tweetの保管に失敗しました。"
      end
    end

    if @room.synchro_flag == "OFF" and @room.keep_flag == "OFF"
      flash[:tweet_notice] = "<span style=\"color: red;\">Twitter連携もしくはTweet保管をONにして下さい。</span>"
    end

    redirect_to :action => "index", :room_id => params[:room_id], :menu => params[:menu] and return
  end
  
  #------------#
  # char_count #
  #------------#
  def char_count
    render :text => ( 140 - 1 - params[:value].length - params[:hash_tag_length].to_i )
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @tweet = Tweet.find_by_args( :id => params[:id], :user_id => session[:user_id] )
    
    unless @tweet.destroy
      flash[:notice] = "Tweetの削除に失敗しました。"
    end

    redirect_to :action => "index", :room_id => @tweet.room_id, :menu => params[:menu] and return
  end

end
