class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def show
    render template: 'lab1'
  end

  def getOrd alphabet
    ord = {}
    for i in Array(0..alphabet.length - 1)
      ord[alphabet[i]] = i
    end
    return ord
  end

  def encrypt
    # TODO(cosmin): add server-side validation
    alphabet = params[:alphabet].to_s
    m = alphabet.length
    alphabet = alphabet + " "
    ord = getOrd alphabet
    alpha = params[:alpha].to_i
    beta = params[:beta].to_i
    text = params[:text].to_s
    logger.info "Encrypting " + text
    logger.info "alpha " + alpha.to_s
    logger.info "beta " + beta.to_s
    encrypted = text.split("")
        .map{|x| ord[x]}
        .map{|id| id == m ? m : (alpha * id + beta) % m}
        .map{|ide| alphabet[ide]}
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
    # TODO(cosmin): add server-side validation
    alphabet = params[:alphabet].to_s
    m = alphabet.length
    alphabet = alphabet + " "
    ord = getOrd alphabet
    alpha = params[:alpha].to_i
    beta = params[:beta].to_i
    ciphertext = params[:text]
    logger.info "Dencrypting " + ciphertext
    logger.info "alpha " + alpha.to_s
    logger.info "beta " + beta.to_s
    alpha_inv = get_inverse(alpha, m)
    logger.info "alpha_in " + alpha_inv.to_s
    decrypted = ciphertext.split("")
        .map{|ch| ord[ch]}
        .map{|id| id == m ? m : (alpha_inv * (id - beta + m)) % m}
        .map{|idx| alphabet[idx]}
        .join
    logger.info "Decrypted: " + decrypted.to_s
    render template: "decrypt", :locals => { :decrypted => decrypted, :ciphertext => ciphertext }
  end
end
