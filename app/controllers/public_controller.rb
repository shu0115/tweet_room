class PublicController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @rooms = Room.paginate_by_args_option( { :mode => "public" }, { :page => params[:page], :per_page => $per_page, :order => "created_at", :include => "user" } )
  end

end