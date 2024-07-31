class CreateClientProviders < ActiveRecord::Migration[7.1]
  def change
    create_table :client_providers do |t|
      t.references :client, null: false, foreign_key: true, index: false
      t.references :provider, null: false, foreign_key: true, index: false
      t.integer :plan, null: false, default: 0
      t.boolean :primary, default: false, null: false

      t.timestamps
    end

    add_index :client_providers, [:client_id, :provider_id], unique: true
  end
end
