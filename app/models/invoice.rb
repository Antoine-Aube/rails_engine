class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  validates_presence_of :status

  # enum :status, ["shipped", "pending", "returned"]
end