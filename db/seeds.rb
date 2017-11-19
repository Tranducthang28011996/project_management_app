require "faker"
(0..100).each do |id|
  User.create name: Faker::Name.name, email: "user_example_#{id}@gmail.com",
    password: "123456", password_confirmation: "123456"
end

tvd = User.create name: "Vu Duc Tuyen", email: "tuyenvuduc@gmail.com",
    password: "123456", password_confirmation: "123456"

puts "create project"

10.times do |variable|
  project = tvd.projects.create name: Faker::Name.name
  project.create_team name: "_team_project_#{project.id}"
end


%w(new in_process resolved testing done).each do |status|
  Status.create name: status, description: status
end

puts "create status done"

(1..2).each do |time|
  project = Project.find_by id: time
  Status.all.each do |status|
    5.times do |task|
      project.tasks.create name: Faker::Name.name, status_id: status.id, user_id: project.owner.id
    end
  end
end
puts "create task done"

Label.create [{name: "success"}, {name: "danger"},
             {name: "info"}, {name: "primary"},
             {name: "warning"}]

puts "create label done"