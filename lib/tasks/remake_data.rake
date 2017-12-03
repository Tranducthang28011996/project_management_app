namespace :db do

  task :remake_data do
    %w[db:migrate:reset db:seed].each do |task|
      Rake::Task[task].invoke
    end
  end
end
