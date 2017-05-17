class User < ApplicationRecord
  include Clearance::User

  has_many :leaves
  validates_confirmation_of :password
  before_save :generate_private_token


  def generate_private_token
    self.private_token = SecureRandom.hex(10) if private_token.blank?
  end
  
end
