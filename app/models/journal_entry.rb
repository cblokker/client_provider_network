class JournalEntry < ApplicationRecord
  ### ASSOCIATIONS ###
  belongs_to :client

  ### VALIDATIONS ###
  validates :content, presence: true
end
