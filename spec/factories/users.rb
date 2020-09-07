FactoryBot.define do
  factory :admin_user, class: User do
    name { 'テストユーザー1' }
    email { 'example@icloud.com' }
    password { 'password' }
    admin { 'true' }
  end
  factory :general_user, class: User do
    name { 'テストユーザー2' }
    email { 'example1@icloud.com' }
    password { 'password' }
    admin { 'false' }
  end
end
