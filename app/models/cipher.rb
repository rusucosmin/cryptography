class Cipher
  include ActiveModel::Validations

  def alpha_and_alphabet_size_shold_be_coprime
    if alphabet.length.gcd(alpha) != 1
      errors.add(:alpha, :alphabet, "alpha and alphabet size should be coprime")
    end
  end

  validates :alphabet, presence: true
  validates :alpha, presence:true, numericality: { only_integer: true }
  validates :beta, presence: true, numericality: { only_integer: true }
  validates :text, presence: true
  validate :alpha_and_alphabet_size_should_be_coprime
end
