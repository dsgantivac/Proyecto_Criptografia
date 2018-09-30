
require 'faker'
require "./app/controllers/Algorithms/des.rb"
require "./app/controllers/Algorithms/polarcrypt.rb"

puts 'Llenando'
20.times do |row|
  
  user=User.create!(email: row.to_s+"@"+row.to_s+".com",
  password: row, 
  conf_password: row, 
  name: Faker::Name.female_first_name,
  pin: (0...8).map { (65 + rand(26)).chr }.join)

  rand(5..20).times do
    cr=""
    text=""
    enc=rand(1..2)
    
    ran=rand(1..10)
    
    if ran <=3
      text=Faker::HarryPotter.quote.sub("’", "'").to_s.force_encoding("ASCII-8BIT")
    elsif ran <=6
      text=Faker::VForVendetta.speech.sub("’", "'").to_s.force_encoding("ASCII-8BIT")
    else
      text=Faker::ChuckNorris.fact.sub("’", "'").to_s.force_encoding("ASCII-8BIT")
    end 
    if enc == 1
      cr="DES"
      text=encrypt(text, user.pin)
    else
      cr="PolarCrypt"
      text=encriptar(text, user.pin)
    end
    Article.create!(
      encryptType: cr,
      user_id: user.id,
      title: Faker::Date.between(2.months.ago, Date.today), 
      body: text 
    )
  
  end

end