class ClientProvider < ApplicationRecord
  ### ASSOCIATIONS ###
  belongs_to :client
  belongs_to :provider

  ### VALIDATIONS ###
  # validates :plan, presence: true, inclusion: { in: %w[basic premium] }
  validate :only_one_primary_per_client

  ### ENUMS ###
  enum :plan, { basic: 0, premium: 1 }

  private

  def only_one_primary_per_client
    if primary? && ClientProvider.where(client_id: client_id, primary: true).exists?
      errors.add(:primary, 'only one primary provider per user') # i18n
    end
  end
end
