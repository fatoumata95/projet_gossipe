Faker::Config.locale = :fr

City.destroy_all
User.destroy_all
Gossip.destroy_all
Tag.destroy_all
JoinTableGossipsTag.destroy_all
PrivateMessage.destroy_all
JoinTableMessageRecipient.destroy_all

10.times do
  city = City.create!(zip_code:  Faker::Address.zip_code, name:  Faker::Address.city)
end

10.times do
  user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraph, email: Faker::Internet.email, age: Faker::Number.between(from: 18, to: 78), city: City.find(rand(1..10)))
end

20.times do
  gossip = Gossip.create!(
    title:  Faker::Lorem.sentence, 
    content:  Faker::Lorem.paragraph, 
    user: User.find(rand(1..10)))
end

10.times do
  tag = Tag.create!(
    title:  Faker::Lorem.word)
end

20.times do
  join_table_gossips_tag = JoinTableGossipsTag.create!(
    tag:  Tag.find(rand(1..10)), 
    gossip: Gossip.find(rand(1..20)))
end

20.times do # Permet d'envoyer un message depuis un sender à 1 ou plusieurs recipients, en évitant de s'envoyer le message à soi-même et d'envoyer le message plusieurs fois au même recipient
  senders = User.all.to_a # On récupère tous les users dans un array
  sender = senders.sample # On récupère un user au hasard
  senders.delete(sender) # On enlève de l'array de tous les user le sender
  content = Faker::Lorem.sentence
  nb_recipients = rand(1..senders.length) # On génère un nombre de recipients au hasard
  nb_recipients.times do
    recipient = senders.sample # On récupère un recipient depuis l'array 
    senders.delete(recipient) # On le remove de l'array
    JoinTableMessageRecipient.create(private_message: PrivateMessage.create(sender: sender, content: content), recipient: recipient)
  end
end