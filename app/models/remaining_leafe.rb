class RemainingLeafe < ApplicationRecord
	belongs_to :user, foreign_key: :remaining_leafe_id
end
