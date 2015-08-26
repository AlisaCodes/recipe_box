require 'spec_helper'

describe Recipe do

  it 'returns false if the length is greater than 100 or less than 2' do
    recipe = Recipe.new({instructions: 'put the lime in the coconut', rating: 1, dish_name: 'c', pic_link: 'www.coco.com'})
    expect(recipe.save).to eq false
  end

  it 'returns false if integer is greater than 5 and less than 0' do
    recipe = Recipe.new({instructions: 'put the lime in the coconut', rating: 'bob', dish_name: 'coco-lime', pic_link: 'www.coco.com'})
    expect(recipe.save).to eq false
  end

  it 'returns false if integer is less than 0' do
    recipe = Recipe.new({instructions: 'put the lime in the coconut', rating: -1, dish_name: 'coco-lime', pic_link: 'www.coco.com'})
    expect(recipe.save).to eq false
  end
end
