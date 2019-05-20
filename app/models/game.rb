class Game < ApplicationRecord
  validates :name, :price, presence: true
  validates :name, uniqueness: true

  def forEveryone?
    true
  end

  def add num1, num2
    num1 + num2
  end

  def formattedGameAndPrice
    "#{name} - $#{price}"
  end

  def self.description
    'Wow fun times'
  end
end
