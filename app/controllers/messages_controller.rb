class MessagesController < ApplicationController

  def index
#    print "[ LOCAL_OAUTH_CONSUMER_KEY ] : "; p LOCAL_OAUTH_CONSUMER_KEY ;
#    print "[ LOCAL_OAUTH_CONSUMER_SECRET ] : "; p LOCAL_OAUTH_CONSUMER_SECRET ;
#    print "[ session[:user_id] ] : "; p session[:user_id] ;
#    print "[ current_user ] : "; p current_user ;
#    user = User.find_by_args( :id => session[:user_id] )
#    user_get = user.twitter.get( '/account/verify_credentials' )
#    print "[ user_get ] : "; p user_get ;
    
#    search_param = ""
#    search_param += "?q=#{CGI.escape( @room.hash_tag )}"
#    search_param += "&locale=ja"
#    search_param += "&lang=ja"
#    search_param += "&rpp=10"
#    search_param += "&page=1"
#    search_param += "&show_user=false"
#    search_param += "&result_type=recent"

    user = User.find_by_args( :id => session[:user_id] )
#    search_param = Tweet.set_search_param( :q => @room.hash_tag )
#    @twitter_get = current_user.twitter.get( "http://search.twitter.com/search.json#{search_param}" )    
    @twitter_get = current_user.twitter.get( "http://api.twitter.com/1/lists.json?user_id=#{user.twitter_id}" )    
    
    print "[ @twitter_get ] : "; p @twitter_get ;
    
    render :layout => false
  end
  
  def create
    if current_user.twitter.post('/statuses/update.json', :status => "偉大なるHelloWorld")
      flash[:success] = "おめでとう！偉大なるHelloWorldは成功した。"
      redirect_to root_path
    else
      flash[:error] = "残念だが、偉大なるHelloWorldは失敗に終わった。"
      render :action => 'index'
    end
  end
end
