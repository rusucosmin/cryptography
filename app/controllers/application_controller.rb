class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def show
    render template: 'lab1'
  end
  def encrypt
    # TODO(rusucosmin): add here the encryption logic
    render html: params["1"].to_s + params[:text].to_s
  end

  def decrypt
    # TODO(rusucosmin): add here the decryption logic
  end
end
