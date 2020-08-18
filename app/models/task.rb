class Task < ApplicationRecord

  validates :title, :content, presence: true
  validates :title, length: { maximum:50 }
  validates :content, length: { maximum:100 }

end
