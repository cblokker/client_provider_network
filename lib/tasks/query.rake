require "awesome_print"

namespace :query do
  desc "Run sample queries and print results"
  task run: :environment do
    provider = Provider.first
    client = Client.first
  

    puts "## 1. Find all clients for a particular provider: privider #{provider.id}"
    puts "      Through model defined associations:"
    ap provider.clients

    puts "      Outside of model defined associations:"
    ap Client.joins(:client_providers)
             .where(client_providers: { provider_id: provider.id })

    
    puts "## 2. Find all providers for a particular client: Client #{client.id}"
    puts "      Through model defined associations:"
    ap client.providers

    puts "      Outside of model defined associations:"
    ap Provider.joins(:client_providers)
               .where(client_providers: { client_id: client.id })
    

    puts "## 3. Find all of a particular client's journal entries, sorted by date posted: client #{client.id}"
    puts "      Through model defined associations:"
    ap client.journal_entries.order(created_at: :desc)

    puts "      Outside of model defined associations:"
    ap JournalEntry.where(client_id: client.id)
                   .order(created_at: :desc)


    puts "## 4. Find all of the journal entries of all of the clients of a particular provider, sorted by date posted: Provider: #{provider.id}"
    puts "      Through model defined associations:"    
    ap provider.clients
                .joins(:journal_entries)
                .order('journal_entries.created_at DESC')
                .select('journal_entries.*')

    puts "      Outside of model defined associations:"
    ap JournalEntry.joins(client: :client_providers)
                   .where(client_providers: { provider_id: provider.id })
                   .order(created_at: :desc)
  end
end
