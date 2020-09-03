class User < ApplicationRecord

  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, 
                    length: { maximum: 30 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }

  has_many :tasks, dependent: :destroy
  delegate :title, 
           :content, 
           :expired,
           :status, 
           :priority, to: :user, prefix: true

end
