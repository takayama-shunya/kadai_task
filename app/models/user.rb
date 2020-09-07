class User < ApplicationRecord

  before_validation { email.downcase! }
  before_update :admin_update_limit
  before_destroy :admin_destroy_limit

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
  
  private

  def admin_update_limit
    if User.where(admin: "true").count < 1 && self.admin == false
      throw :abort
    end
  end

  def admin_destroy_limit
    if User.where(admin: "true").count < 1
      throw :abort
    end
  end

end
