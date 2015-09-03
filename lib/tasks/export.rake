namespace :export do
  desc "Prints Offers.all in a seeds.rb way."
  task :seeds_format1 => :environment do
    Offer.order(:id).all.each do |offer|
      puts "Offer.create(#{offer.serializable_hash.delete_if {|key, value| ['created_at', 'updated_at', 'id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
  task :seeds_format2 => :environment do
    User.order(:id).all.each do |user|
      puts "User.create(#{user.serializable_hash.delete_if {|key, value| ['created_at', 'updated_at', 'id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end
