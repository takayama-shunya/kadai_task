User.create!(
  name: 'admin_user',
  email: 'admin@icloud.com',
  password: 'admin',
  password_confirmation: 'admin',
  admin: true
)

10.times do |n|
  User.create!(
    name: "user_#{n + 1}",
    email: "user_#{n +1}@icloud.com",
    password: "password",
    password_confirmation: "password",
    admin: false )
end

10.times do |n|
  Label.create!(
    name: "label_#{n + 1}"
  )
end

task_list = []
10.times do |n|
  task_list <<
    { title: "test_#{n + 1}",
      content: "example_#{n + 1}",
      expired: Time.current.next_week,
      status: "着手中",
      priority: 1,
      user_id: User.ids.sample,
      label_ids: Label.ids.sample }
end
Task.create!(task_list)