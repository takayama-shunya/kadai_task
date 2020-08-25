class Task < ApplicationRecord

  before_create :expired_add_time

  validates :title, :content, presence: true
  validates :title, length: { maximum:50 }
  validates :content, length: { maximum:100 }

  enum priority: { 低: 0, 中: 1, 高: 2 }

  scope :search, -> (search_params) do
    return if search_params.blank?

    title_like(search_params[:title])
      .status_name(search_params[:status])
  end
  scope :title_like, -> (title) { where("title LIKE ?", "%#{title}%") if title.present? }
  scope :status_name, -> (status) { where(status: status) if status.present? }

  private
  def expired_add_time
    now = Time.current
    self.expired = now.next_month if expired.blank?
  end

end
