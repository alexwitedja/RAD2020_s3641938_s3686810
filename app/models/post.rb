class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,
  validates :content, presence: true,
  validates :topic, presence: true

end
