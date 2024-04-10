class Relationship < ApplicationRecord
	belongs_to :follower, class_name: 'User'
	belongs_to :following, class_name: 'User'

	after_create :send_email

	private
	def send_email
		RelationshipMailer.new_follower(following, follower).deliver_now
	end
end
