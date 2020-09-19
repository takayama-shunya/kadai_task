FactoryBot.define do
  factory :label do
    name { 'デフォルトラベル1' }
  end
  factory :second_label, class: Label do
    name { 'デフォルトラベル2' }
  end
  factory :third_label, class: Label do 
    name { 'デフォルトラベル3' }
    association :user, factory: :admin_user
  end
  factory :fourth_label, class: Label do 
    name { 'デフォルトラベル4' }
    association :user, factory: :general_user
  end
end
