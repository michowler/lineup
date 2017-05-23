class User < ApplicationRecord
  include Clearance::User
  require 'carrierwave/orm/activerecord'
  mount_uploader :avatar, AvatarUploader
  has_many :leaves, dependent: :destroy
  belongs_to :manager, class_name: "User"
  belongs_to :total_leafe, class_name: "TotalLeafe",dependent: :destroy
  belongs_to :remaining_leafe,dependent: :destroy
  has_many :members, class_name: "User", foreign_key: :manager_id

  validates_confirmation_of :password
  before_save :generate_private_token

  enum position: ["Employee","Manager"]
  enum department: ["Human Resource","Accounting","Marketing"]

  accepts_nested_attributes_for :total_leafe, :allow_destroy => true
  
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
