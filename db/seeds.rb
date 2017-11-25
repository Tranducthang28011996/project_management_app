require "faker"
(0..100).each do |id|
  User.create name: Faker::Name.name, email: "user_example_#{id}@gmail.com",
    password: "123456", password_confirmation: "123456", role: :member
end
User.create name: "Admin", role: :admin, password: "123456", password_confirmation: "123456", email: "admin@gmail.com"
tvd = User.create name: "Vu Duc Tuyen", email: "tuyenvuduc@gmail.com",
    password: "123456", password_confirmation: "123456", role: :member

%w(new in_process resolved testing done).each do |status|
  Status.create name: status, description: status
end

puts "create status done"
Label.create [{name: "success"}, {name: "danger"},
             {name: "info"}, {name: "primary"},
             {name: "warning"}]

puts "create label done"

