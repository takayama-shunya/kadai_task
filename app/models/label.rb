class Label < ApplicationRecord
  
  validates :name, presence: true, length: { maximum:20 }
  validates :name, uniqueness: true

  has_many :label_tags, dependent: :destroy
  has_many :tasks, through: :label_tags
  belongs_to :user, optional: true

end
