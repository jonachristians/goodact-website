namespace :user_mods do
  desc "Change all user first, last and usernames do FakePerson ones"
  task change_names: :environment do
    User.find_each do |user|
      fake = FakePerson.new
      user.first_name = fake.first_name
      user.last_name = fake.last_name
      user.username = fake.username
      user.save
    end
  end

end
