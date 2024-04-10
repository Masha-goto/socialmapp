class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	validates :account, presence: true, length: { minimum: 2 }


	has_many :posts, dependent: :destroy
	has_many :likes, dependent: :destroy

	has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
	has_many :followings, through: :following_relationships, source: :following

	has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
	has_many :followers, through: :follower_relationships, source: :follower

	has_many :comments, dependent: :destroy
	has_one :profile, dependent: :destroy

	def has_written?(post)
		posts.exists?(id: post.id)
	end

	def has_liked?(post)
		likes.exists?(post_id: post.id)
	end

	def prepare_profile
		profile || build_profile
	end

	def follow!(user)
		user_id = get_user_id(user)
		following_relationships.create!(following_id: user_id)
	end

	def unfollow!(user)
		user_id = get_user_id(user)
		relation = following_relationships.find_by!(following_id: user_id)
		relation.destroy!
	end

	def has_followed?(user)
		following_relationships.exists?(following_id: user.id)
	end

	def avatar_image
		if profile&.avatar&.attached?
			profile.avatar
		else
			'default-avatar.png'
		end
	end

	private
	def get_user_id(user)
		if user.is_a?(User)
			user.id
		else
			user
		end
	end
end
