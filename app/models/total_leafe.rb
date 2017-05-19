class TotalLeafe < ApplicationRecord
	belongs_to :user, foreign_key: :total_leafe_id
end
