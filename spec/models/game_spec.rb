require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "Validations" do
    it "is not valid without a name" do
      game = Game.new(
        name: nil
      )
  
      expect(game).to_not be_valid
    end

    it "is valid with a name" do
      game = Game.new(
        name: 'God of War',
        price: 100
      )
  
      expect(game).to be_valid
    end

    it "is not valid without a price" do
      game = Game.new(
        name: 'God of War',
        price: nil
      )
  
      expect(game).to_not be_valid
    end

    it "should have a unique name" do
      game = Game.new(
        name: 'Half Life 2',
        price: 33
      )
      
      game.save

      game = Game.new(
        name: 'FIFA 1998',
        price: 33
      )
      
      game.save


      game2 = Game.new(
        name: 'Half Life 2',
        price: 33
      )
  
      expect(game2).to_not be_valid
    end

  end  

  describe "Instance Methods" do
    it "should return true as a rating 'For Everyone'" do
      game = Game.new(
        name: 'Left 4 Dead',
        price: 70
      )
  
      expect(game.forEveryone?).to be true
    end

    it "should return the proper sum" do
      game = Game.new(
        name: 'Left 4 Dead',
        price: 70
      )
  
      expect(game.add(1, 1)).to be 2
    end

    it "should return formatted game and price" do
      game = Game.new(
        name: 'Left 4 Dead',
        price: 70
      )
  
      expect(game.formattedGameAndPrice).to eq 'Left 4 Dead - $70'

      game = Game.new(
        name: 'Heroes of Newerth',
        price: 52
      )
      
      expect(game.formattedGameAndPrice).to eq 'Heroes of Newerth - $52'
    end

  end

  describe "Class Methods" do
    it "should return a description of what Games are" do
      expect(Game.description).to eq 'Wow fun times'
    end

  end

end
