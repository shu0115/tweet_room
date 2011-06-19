class Room < ActiveRecord::Base
  belongs_to :user
  has_one :tweet
  
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

  #-------------------------#
  # self.all_by_args_option #
  #-------------------------#
  def self.all_by_args_option( args, option )
    find_args = Hash.new
    find_args[:conditions] = args
    find_args[:order] = option[:order] unless option[:order].blank?
    find_args[:include] = option[:include] unless option[:include].blank?
    find_args[:limit] = option[:limit] unless option[:limit].blank?
    find_args[:select] = option[:select] unless option[:select].blank?
    
    return self.all( find_args )
  end

  #------------------------------#
  # self.paginate_by_args_option #
  #------------------------------#
  def self.paginate_by_args_option( args, option )
    find_args = Hash.new
    find_args[:conditions] = args
    find_args[:order] = option[:order] unless option[:order].blank?
    find_args[:include] = option[:include] unless option[:include].blank?
    find_args[:limit] = option[:limit] unless option[:limit].blank?
    find_args[:select] = option[:select] unless option[:select].blank?
    find_args[:page] = option[:page]
    find_args[:per_page] = option[:per_page] unless option[:per_page].blank?
    
    return self.paginate( find_args )
  end

end
