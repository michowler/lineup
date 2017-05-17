class User < ApplicationRecord
  include Clearance::User

  has_many :leaves
  validates_confirmation_of :password
  before_save :generate_private_token


  # def self.authenticate!(email, password)
  #   byebug
  #       user = User.find_by(email: email)
  #       return false if user.nil? || (user.password != password)
  #       return user
  # end

  def generate_private_token
    self.private_token = SecureRandom.hex(10) if private_token.blank?
  end
  
end
