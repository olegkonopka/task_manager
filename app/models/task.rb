class Task < ActiveRecord::Base
	has_and_belongs_to_many :users
	validates :title, presence: true, length: { maximum: 30 }
	validates :description, presence: true, length: { maximum: 800 }
end
