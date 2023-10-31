class Tea < ApplicationRecord
  has_and_belongs_to_many :subscription

  validates_presence_of :title, :description, :temperature, :brew_time
end
