class Label < ApplicationRecord
  has_many :label_tags, dependent: :destroy
  has_many :tasks, through: :label_tags
end
