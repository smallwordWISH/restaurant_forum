class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  mount_uploader :avatar, AvatarUploader

  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favorited_resaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :inverse_followships, source: :user


  def following?(user)
    self.followings.include?(user)
  end
  
  def admin?
    self.role == "admin"
  end
end
