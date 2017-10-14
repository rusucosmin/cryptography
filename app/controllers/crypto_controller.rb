class CryptoController < ActionController::API
  def encrypt
    render json: "{\"encrypted\": \"cosmin\"}"
  end
  def decrypt
    render json: "{\"decrypted\": \"cosmin\"}"
  end
end
