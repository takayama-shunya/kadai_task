5.times do |n|
  Label.create!(
    name: "label_#{n + 1}"
  )
end