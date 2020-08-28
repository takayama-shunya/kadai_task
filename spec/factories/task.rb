FactoryBot.define do
  factory :task do
    title { 'デフォルトタイトル1'}
    content { 'デフォルトコンテント1' }
    expired { Time.current.next_week }
    status { "未着手" }
    priority { 0 }
  end
  factory :second_task, class: Task do
    title { 'デフォルトタイトル2'}
    content { 'デフォルトコンテント2' }
    expired { Time.current.since(2.weeks) }
    status { "着手中" }
    priority { 2 }
  end
end