# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

JournalEntry.delete_all
ClientProvider.delete_all
Client.delete_all
Provider.delete_all
User.delete_all


# NOTE - not designed for performance. Use insert/upsert & reduce # of read/write queries
ActiveRecord::Base.transaction do
  # Create 10 providers
  providers = 5.times.map do |i|
    user = User.create!(
      email: "user#{i + 1}-provider@gmail.com",
      password_digest: "password" # don't worry about encryption b/c out of scope of question
    )

    Provider.create!(
      user: user,
      name: "Provider #{i}"
    )
  end

  # Create 100 clients
  clients = 10.times.map do |i|
    user = User.create!(
      email: "user#{i + 1}-client@gmail.com",
      password_digest: "password" # don't worry about encryption b/c out of scope of question
    )

    client = Client.create!(
      user_id: user.id,
      name: "Client #{i}"
    )

    primary_provider = providers.sample

    ClientProvider.create(
      provider: primary_provider,
      client: client,
      plan: [0, 1].sample,
      primary: true
    )

    client
  end

  # Assign only some clients with secondary providers
  clients.first(10).each do |client|
    primary_provider = ClientProvider.find_by(client: client, primary: true)&.provider

    ClientProvider.create!(
      client: client,
      provider: (providers - [primary_provider]).sample,
      plan: [0, 1].sample,
      primary: false
    )
  end

  # Create journal entries for clients
  clients.each do |client|
    rand(1..10).times do |i|
      JournalEntry.create!(
        client: client,
        content: "Once upon a time, #{client.name} wrote some things, for the #{i}th time"
      )
    end
  end
end
