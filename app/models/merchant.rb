class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  validates_presence_of :name

  # def self.find_by_name(name)
  #   where('name ILIKE ?', "%#{name}%").first
  # end

  # def self.find_all_by_name(name)
  #   where('name ILIKE ?', "%#{name}%")
  # end 
end