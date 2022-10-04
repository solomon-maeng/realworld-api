class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, uniqueness: { case_sensitive: false }, allow_blank: false
  validates :email, :username, :password_digest, presence: true

end