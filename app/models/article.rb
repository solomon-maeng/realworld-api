class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  # TODO tags, favorites 매핑 처리

  validates :title, :body, :description, :slug, presence: true
end