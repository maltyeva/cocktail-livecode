require 'open-uri'


if Rails.env.development?
  Dose.destroy_all
  Ingredient.destroy_all
  Cocktail.destroy_all
end

puts "deleted old data"


url = "https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json"

opened_url = open(url).read
parsed_url = JSON.parse(opened_url)


parsed_url.each do |cocktail|
  c = Cocktail.create!(name: cocktail["name"])
  cocktail["ingredients"].each do |ingredient|
    # Ingredient
    if ingredient["ingredient"]
      i = Ingredient.find_or_create_by(name: ingredient["label"].present? ? ingredient["label"] : ingredient["ingredient"])
      # Dose
      d = Dose.create!(description: ingredient["amount"].to_s + " " + ingredient["unit"], cocktail: c, ingredient: i)
      puts "Added #{d.description} of #{i.name} to #{c.name}"
    end
  end
end
