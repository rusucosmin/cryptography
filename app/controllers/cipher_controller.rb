class CipherController < ActionController::Base
  def new
    @cipher = Cipher.new
  end
end
