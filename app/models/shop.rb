class Shop < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
  has_many :tasks
  has_many :users, through: :tasks
end
