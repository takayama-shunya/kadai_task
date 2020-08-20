FactoryBot.define do
  factory :task do
    title { 'デフォルトタイトル1'}
    content { 'デフォルトコンテント1' }
    expired { Time.current.next_week }
  end
  factory :second_task, class: Task do
    title { 'デフォルトタイトル2'}
    content { 'デフォルトコンテント2' }
    expired { Time.current.since(2.weeks) }
  end
end