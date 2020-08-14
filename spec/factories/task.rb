FactoryBot.define do
  factory :task do
    title { 'デフォルトタイトル1'}
    content { 'デフォルトコンテント1' }
  end
  factory :second_task, class: Task do
    title { 'デフォルトタイトル2'}
    content { 'デフォルトコンテント2' }
  end
end