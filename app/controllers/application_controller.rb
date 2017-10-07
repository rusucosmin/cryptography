class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def show
    render template: 'lab1'
  end
  def encrypt
    # TODO(rusucosmin): add server-side validation
    ord = {}
    Array(0..26).each do |x|
      ord[params[x.to_s].to_s] = x
    end
    alpha = params[:alpha].to_i
    beta = params[:beta].to_i
    text = params[:text]
    logger.info "Encrypting " + text
    logger.info "alpha " + alpha.to_s
    logger.info "beta " + beta.to_s
    encrypted = text.split("")
        .map{|x| ord[x]}
        .map{|id| id == 26 ? 26 : (alpha * id + beta) % 26}
        .map{|ide| params[ide.to_s]}
        .join
    logger.info "Encrypted to " + encrypted
    render template: 'encrypt', :locals => { :encrypted => encrypted, :text => text }
  end

  def get_inverse(alpha, m)
    Array(0..m).each do |x|
      if (x * alpha) % m == 1
        return x
      end
    end
    return nil
  end

  def decrypt
    # TODO(rusucosmin): add server-side validation
    ord = {}
    Array(0..26).each do |x|
      ord[params[x.to_s].to_s] = x
    end
    alpha = params[:alpha].to_i
    beta = params[:beta].to_i
    ciphertext = params[:ciphertext]
    logger.info "Dencrypting " + ciphertext
    logger.info "alpha " + alpha.to_s
    logger.info "beta " + beta.to_s
    alpha_inv = get_inverse(alpha, 26)
    logger.info "alpha_in " + alpha_inv.to_s
    decrypted = ciphertext.split("")
        .map{|ch| ord[ch]}
        .map{|id| id == 26 ? 26 : (alpha_inv * (id - beta + 26)) % 26}
        .map{|idx| params[idx.to_s]}
        .join
    logger.info "Decrypted: " + decrypted.to_s
    render template: "decrypt", :locals => { :decrypted => decrypted, :ciphertext => ciphertext }
  end
end
