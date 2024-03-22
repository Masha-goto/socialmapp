class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	validates :account, presence: true, length: { minimum: 2 }


	has_many :posts, dependent: :destroy
	has_one :profile, dependent: :destroy

	def prepare_profile
		profile || build_profile
	end

	def avatar_image
		if profile&.avatar&.attached?
			profile.avatar
		else
			'default-avatar.png'
		end
	end
end
