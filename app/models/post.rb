class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 6 }
  validates :content, presence: true, length: { minimum: 6 }
  validates :topic, presence: true

end
