// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require popper
//= require bootstrap
//= require_tree .

$(document).ready(function(){
  isEncrypt = true;
  populate(validate())
  $("#form input").on("input", function() {
    populate(validate())
  })
  $("#locker").click(function() {
    $(".lock-box").toggleClass("lock-box-active")
    $(".lock-circle").toggleClass("lock-circle-active")
    isEncrypt = !isEncrypt
    if (isEncrypt) {
      $("#title").text("Affine cipher - Encrypt")
      $("#text").val("text to encrypt")
      $("#text-label").text("Text to encrypt")
      $("#result-label").text("Encrypted")
    } else {
      $("#title").text("Affine cipher - Decrypt")
      $("#text").val("ufyu up efdszqu")
      $("#text-label").text("Text to decrypt")
      $("#result-label").text("Decrypted")
    }
    populate(validate())
  })
  function getModularInverse(alpha, m) {
    for (inv = 0; inv < m; ++ inv) {
      if ((alpha * inv) % m == 1)
        return alpha
    }
    return -1;
  }
  function decrypt(alphabet, alpha, beta, text) {
    idx = {}
    for (x = 0; x < alphabet.length; ++ x) {
      idx[alphabet[x]] = x
    }
    dec = ""
    inv = getModularInverse(alpha, alphabet.length)
    if (x == -1) {
      alert ("No modular inverse for alpha and length of alphabet")
      return ;
    }
    for (i = 0; i < text.length; ++ i) {
      if (text[i] == " ") {
        dec += " ";
        continue;
      }
      ind = idx[text[i]];
      newind = inv * (ind - beta + alphabet.length) % alphabet.length;
      dec += alphabet[newind];
    }
    return dec
  }
  function encrypt(alphabet, alpha, beta, text) {
    idx = {}
    for (x = 0; x < alphabet.length; ++ x) {
      idx[alphabet[x]] = x
    }
    enc = ""
    for (x = 0; x < text.length; ++ x) {
      if (text[x] == " ") {
          enc += " ";
          continue;
      }
      ind = idx[text[x]]
      newind = (alpha * ind + beta)
      enc += alphabet[newind]
    }
    return enc
  }
  function populate(valid) {
    if (valid == true) {
      if (isEncrypt) {
        $("#result").val(encrypt($("#alphabet").val(),
                            Number($("#alpha").val()),
                            Number($("#beta").val()),
                            $("#text").val()));
      } else {
        $("#result").val(decrypt($("#alphabet").val(),
                            Number($("#alpha").val()),
                            Number($("#beta").val()),
                            $("#text").val()));
      }
    } else {
      $("#result").val("")
    }
  }
  function validate() {
    valid = true
    // check the alphabet
    if ($("#alphabet").val().length == 0) {
      $("#alphabet").addClass("is-invalid")
      valid = false;
    } else {
      $("#alphabet").removeClass("is-invalid")
    }
    // check  alpha
    if ($("#alpha").val().length == 0
        || !Number.isInteger(Number(($("#alpha").val())))) {
      $("#alpha").addClass("is-invalid")
      valid = false;
    } else {
      $("#alpha").removeClass("is-invalid")
    }
    // check beta
    if ($("#beta").val().length == 0
        || !Number.isInteger(Number(($("#beta").val())))) {
      $("#beta").addClass("is-invalid")
      valid = false;
    } else {
      $("#beta").removeClass("is-invalid")
    }
    if ($("#text").val().replace(/ /g, "").match("[^" + $("#alphabet").val() + "]")) {
      $("#text").addClass("is-invalid")
      valid = false;
    } else {
      $("#text").removeClass("is-invalid")
    }
    return valid;
  }
})
