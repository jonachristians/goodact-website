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
      user.update image: "maya/#{rand(1..15)}.jpg"
    end
  end

  def set_ran_user_image!(id)
    user = User.find(id)
    user.update image: "maya/#{rand(1..15)}.jpg"
  end
end
