class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :email, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: { case_sensitive: false }

  has_many :follows
  has_many :followers, through: :follows
end
