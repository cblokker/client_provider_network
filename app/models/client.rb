class Client < ApplicationRecord
  ### ASSOCIATIONS ###
  belongs_to :user
  has_many :client_providers, dependent: :destroy
  has_many :providers, through: :client_providers
  has_many :journal_entries, dependent: :destroy

  ### SCOPES ###
  scope :primary_provider, -> do
    joins(:providers)
      .find_by(providers: { primary: true })
  end

  ### VALIDATIONS ###
  validates :name, presence: true
end
