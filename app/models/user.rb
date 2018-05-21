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

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: {status: "friend" } )}, through: :friendships
  has_many :send_applys, -> { where(friendships: {status: "applying" } )}, through: :friendships, source: :friend

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :applyers, -> { where(friendships: {status: "applying" } )}, through: :inverse_friendships, source: :user
  has_many :applyer_friends, -> { where(friendships: {status: "friend" } )}, through: :inverse_friendships, source: :user

  def count_followers 
    self.followers_count = self.followers.uniq.size
    self.save
  end

  def following?(user)
    self.followings.include?(user)
  end

  def is_friend?(user)
    if self.friends.include?(user) or self.applyer_friends.include?(user)  
        return true
    else
        return false
    end
  end


  def is_be_applying?(user)
    if self.applyers.include?(user) 
      return true
    else
      return false
    end
  end

  def is_applying?(user)
    if self.send_applys.include?(user) 
      return true
    else
      return false
    end
  end

  
  def admin?
    self.role == "admin"
  end

  def self.get_user_count
    self.all.size
  end

  def get_comment_count
    comments.all.size
  end
end
