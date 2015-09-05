# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ first_name: 'Chicago' }, { first_name: 'Copenhagen' }])
#   Mayor.create(first_name: 'Emanuel', city: cities.first)
Offer.create("description"=>"Helping you with your bicycle", "user_id"=>1, "image"=>"geo/8.jpg")
Offer.create("description"=>"I offer you tea", "user_id"=>1, "image"=>"geo/3.jpg")
Offer.create("description"=>"I have two tickets for Madonna", "user_id"=>2, "image"=>"geo/6.jpg")
Offer.create("description"=>"Hello I offer random", "user_id"=>1, "image"=>"geo/1.jpg")
Offer.create("description"=>"Helesana wikonaka", "user_id"=>1, "image"=>"geo/6.jpg")
User.create("first_name"=>"Karl", "image"=>"maya/10.jpg")
User.create("first_name"=>"Marion", "image"=>"maya/13.jpg")
User.create("first_name"=>"Borja", "image"=>"maya/5.jpg")
User.create("first_name"=>"Mango", "image"=>"maya/3.jpg")
User.create("first_name"=>"Bustoja", "image"=>"maya/1.jpg")
User.create("first_name"=>"Levtanim", "image"=>"maya/15.jpg")
User.create("first_name"=>"Lupinada", "image"=>"maya/2.jpg")
User.create("first_name"=>"Jupijada", "image"=>"maya/6.jpg")
User.create("first_name"=>"Camballtre", "image"=>"maya/10.jpg")
