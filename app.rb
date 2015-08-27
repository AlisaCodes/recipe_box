require 'bundler/setup'
Bundler.require :default, :test

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

# after { ActiveRecord::Base.connection.close }

get '/' do
  erb(:index)
end

### admin portal
get '/admin/recipes/new' do
  @categories = Category.all
  erb :recipe_create_form
end

get '/admin/recipes' do
  @categories = Category.all
  @recipes = Recipe.all
  @ingredients = Ingredient.all
  erb :recipe_crud
end

post '/admin/recipes' do
  instructions = params['instructions']
  dish_name    = params['dish_name']
  pic_link     = params['pic_link']
  rating       = params['rating'].to_i
  ingredients  = params['ingredients'].split(',')

  @recipe      = Recipe.create({ instructions: instructions, dish_name: dish_name, pic_link: pic_link, rating: rating })
  categories   = params['category'].split(',')

  categories.each do |category_name|
    category = Category.find_or_create_by(dish_type: category_name)
    @recipe.categories.push(category)
  end

  ingredients.each do |ingredient|
    if Ingredient.find_by({ item: ingredient })
      ingredient = Ingredient.find_by({ item: ingredient })
    else
      ingredient = Ingredient.create({ item: ingredient })
    end
      @recipe.ingredients.push(ingredient)
  end

  @recipes = Recipe.all
  @categories = Category.all

  erb :recipe_crud
end

get '/admin/recipes/:id' do
  @recipe = Recipe.find(params['id'])
  erb :admin_recipe
end

get '/admin/recipes/:id/edit' do
  @recipe = Recipe.find(params['id'])
  erb :admin_recipe_edit_form
end

patch '/admin/recipes/:id' do
  instructions = params['instructions']
  dish_name    = params['dish_name']
  pic_link     = params['pic_link']
  rating       = params['rating'].to_i
  ingredients  = params['ingredients'].split(',')
  @recipe = Recipe.find(params['id'])

  @recipe.update({ instructions: instructions, dish_name: dish_name, pic_link: pic_link, rating: rating })
  categories = params['category'].split(',')

  categories.each do |category_name|
    category = Category.find_or_create_by(dish_type: category_name)
    @recipe.categories.push(category)
  end

  ingredients.each do |ingredient|
    ingredient = Ingredient.find_by(item: ingredient)
    ingredient.update({ item: ingredient})
    @recipe.ingredients.push(ingredient)
  end

  erb :recipe
end
