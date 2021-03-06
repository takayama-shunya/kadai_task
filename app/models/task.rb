class Task < ApplicationRecord

  before_create :expired_add_time

  validates :title, :content, presence: true
  validates :title, length: { maximum:50 }
  validates :content, length: { maximum:100 }

  belongs_to :user
  delegate :name, :email, :admin, to: :user, prefix: true

  has_many :label_tags, dependent: :destroy 
  has_many :labels, through: :label_tags

  enum priority: { 低: 0, 中: 1, 高: 2 }

  paginates_per 10

  scope :search, -> (search_params) do
    return if search_params.blank?

    title_like(search_params[:title])
      .status_name(search_params[:status])
      .label_id(search_params[:label_id])
  end
  scope :title_like, -> (title) { where("tasks.title LIKE ?", "%#{title}%") if title.present? }
  scope :status_name, -> (status) { where(status: status) if status.present? }
  scope :label_id, -> (label_id) { joins(:labels).where(labels: { id: label_id }) if label_id.present? }

  private

  def expired_add_time
    now = Time.current
    self.expired = now.next_month if expired.blank?
  end

end
