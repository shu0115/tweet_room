# 汎用メソッド用クラス
class Utility

  #----------------------#
  # self.replace_message #
  #----------------------#
  # メッセージ置換
  def self.replace_message( message )
    message = message.gsub( "You have logged in successfully.", "ログインが正常に完了しました。" )
    
    return message
  end

  #--------------#
  # self.f_round #
  #--------------#
  # 小数点四捨五入演算
  def self.f_round( args )
    precision = "1"
    1.upto( args[:precision] ){ precision += "0" }
    args[:number] = ( args[:number].to_f * precision.to_i ).round / precision.to_f

    return args[:number]
  end

  #----------------------#
  # self.digit_delimiter #
  #----------------------#
  # 桁区切り
  def self.digit_delimiter( args )
    args[:number].to_s.reverse.gsub(/(\d{#{args[:digit]}})(?=\d)/, ('\1' + args[:delimiter])).reverse
  end

end