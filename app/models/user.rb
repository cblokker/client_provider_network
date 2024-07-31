class User < ApplicationRecord
  ### Associations ###
  has_one :client, dependent: :destroy
  has_one :provider, dependent: :destroy

  ### Validations ###
  validates :email, presence: true, uniqueness: true # can add email regex etc.
end
