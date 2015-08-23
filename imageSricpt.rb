(1..4).each do |num|
offer = Offer.find(num)
offer.image = "geo/#{rand(1..15)}.jpg"
offer.save
end
