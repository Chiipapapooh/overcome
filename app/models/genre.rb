class Genre < ApplicationRecord
  has_many :news_letters

  validates :name, presence: true, uniqueness: true
end
