class User < TwitterAuth::GenericUser
  # Extend and define your user model as you see fit.
  # All of the authentication logic is handled by the 
  # parent TwitterAuth::GenericUser class.

  has_one :room

  private

  #-------------------#
  # self.find_by_args #
  #-------------------#
  def self.find_by_args( args )
    self.first( :conditions => args )
  end

  #--------------------------#
  # self.find_by_args_option #
  #--------------------------#
  def self.find_by_args_option( args, option )
    find_args = Hash.new
    find_args[:conditions] = args
    find_args[:order] = option[:order] unless option[:order].blank?
    find_args[:include] = option[:include] unless option[:include].blank?
    find_args[:limit] = option[:limit] unless option[:limit].blank?
    find_args[:select] = option[:select] unless option[:select].blank?
    
    return self.first( find_args )
  end

  #--------------------#
  # self.level_master? #
  #--------------------#
  # マスターレベル判定
  def self.level_master?( user_id )
    user = self.find_by_args( :id => user_id )
    unless user.blank?
      if user.login == MASTER_TWITTER_USER
        return true
      else
        return false
      end
    else
      return false
    end
  end

  #---------------------#
  # self.get_login_name #
  #---------------------#
  def self.get_login_name( user_id, login_name )
    unless login_name.blank?
      return login_name
    else
      user = self.find_by_args_option( { :id => user_id }, { :select => "login" } )
      
      unless user.blank?
        return user.login
      else
        return ""
      end
    end
  end

end
