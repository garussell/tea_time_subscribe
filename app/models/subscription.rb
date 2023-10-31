class Subscription < ApplicationRecord
  belongs_to :customer
  has_and_belongs_to_many :teas

  validates_presence_of :title, :price,:status, :frequency 

  enum status: { cancelled: 0, active: 1 }
end
