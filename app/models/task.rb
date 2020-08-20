class Task < ApplicationRecord

  before_create :expired_add_time

  validates :title, :content, presence: true
  validates :title, length: { maximum:50 }
  validates :content, length: { maximum:100 }

  private
  def expired_add_time
    now = Time.current
    self.expired = now.next_month if expired.blank?
  end

end
