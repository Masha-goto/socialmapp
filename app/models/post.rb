class Post < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true
	validates :content, uniqueness: true


	belongs_to :user

	has_many_attached :images
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy
end
