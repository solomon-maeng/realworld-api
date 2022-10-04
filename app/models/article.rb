class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users

  validates :title, :body, :description, :slug, presence: true
end