class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :users

  validates :email, uniqueness: { case_sensitive: true }, allow_blank: false
  validates :email, :username, :password_digest, presence: true

end