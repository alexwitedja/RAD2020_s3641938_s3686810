class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true
  validates :topic, presence: true
  validates :user_id, presence: true
end
