User.create!(
  name: 'admin_user',
  email: 'admin@icloud.com',
  password: 'admin',
  password_confirmation: 'admin',
  admin: true
)

5.times do |n|
  Label.create!(
    name: "label_#{n + 1}"
  )
end