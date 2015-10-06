module ApplicationHelper
  # def imageupdate
  #   (1..4).each do |num|
  #   offer = Offer.find(num)
  #   offer.image = "geo/#{rand(1..15)}.jpg"
  #   offer.save
  #   end
  # end

  def update_offer_descriptions
    Offer.all.each do |o|
      desc = gets.chomp
      o.update(description: desc)
    end
  end

  def user_image_update
    User.all.each do |user|
      user.update image: "maya/#{rand(1..47)}.jpg"
    end
  end

  def offer_image_update
    Offer.all.each do |offer|
      offer.update image: "geo/#{rand(1..35)}.jpg"
    end
  end

  def ran_user_image!(id)
    user = User.find(id)
    user.update image: "maya/#{rand(1..47)}.jpg"
  end

  def set_usernames
    User.all.each do |user|
      tmp = user.first_name
      user.username = tmp
      user.zipcode = rand(10_000..99_999)
      user.save
    end
  end

end
