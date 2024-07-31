class Provider < ApplicationRecord
  ### ASSOCIATIONS ###
  belongs_to :user
  has_many :client_providers, dependent: :destroy
  has_many :clients, through: :client_providers

  ### VALIDATIONS ###
  validates :name, presence: true
end
