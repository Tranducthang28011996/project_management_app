require "faker"

%w(new in_process resolved testing done).each do |status|
  Status.create name: status, description: status
end

Label.create [{name: "success"}, {name: "danger"},
             {name: "info"}, {name: "primary"},
             {name: "warning"}]

tdt = User.create name: "Tran Duc Thang", role: :member, password: "123456", password_confirmation: "123456", email: "tranducthang@gmail.com"

tvd = User.create name: "Vu Duc Tuyen", email: "tuyenvuduc@gmail.com",
    password: "123456", password_confirmation: "123456", role: :member

nn = User.create name: "Nguyen Ngoan", role: :member, password: "123456", password_confirmation: "123456", email: "nguyenngoan@gmail.com"

ptb = User.create name: "Pham Thanh Binh", role: :member, password: "123456", password_confirmation: "123456", email: "phamthanhbinh@gmail.com"

User.create name: "Admin", role: :admin, password: "123456", password_confirmation: "123456", email: "admin@gmail.com"

project1 = tvd.projects.create name: "Fgas", description: Faker::Lorem.paragraphs(1)
project2 = tdt.projects.create name: "Ac", description: Faker::Lorem.paragraphs(1)
project3 = nn.projects.create name: "Wsm", description: Faker::Lorem.paragraphs(1)
project4 = ptb.projects.create name: "Fcsb", description: Faker::Lorem.paragraphs(1)

team1 = project1.create_team name: "_team_project_AC"
team2 = project2.create_team name: "_team_project_Fgas"
team3 = project3.create_team name: "_team_project_Wsm"
team4 = project4.create_team name: "_team_project_Fscb"

Team.all.each do |team|
  User.all.each do |user|
    team.add_member user
  end
end

(1..4).each do |id1|
  (1..5).each do |id2|
    project1.tasks.create user_id: id1, name: Faker::Lorem.sentence, status_id: id2
  end
end

(1..4).each do |id1|
  (1..5).each do |id2|
    project2.tasks.create user_id: id1, name: Faker::Lorem.sentence, status_id: id2
  end
end

(1..4).each do |id1|
  (1..5).each do |id2|
    project3.tasks.create user_id: id1, name: Faker::Lorem.sentence, status_id: id2
  end
end

(1..4).each do |id1|
  (1..5).each do |id2|
    project4.tasks.create user_id: id1, name: Faker::Lorem.sentence, status_id: id2
  end
end

(0..20).each do |id|
  User.create name: Faker::Name.name, email: "user_example_#{id}@gmail.com",
    password: "123456", password_confirmation: "123456", role: :member
end

puts "create user done"
puts "create project done"
puts "create task done"
puts "create status done"
puts "create label done"

