class User < ApplicationRecord
  include Clearance::User

  has_many :leaves
  validates_confirmation_of :password
end
