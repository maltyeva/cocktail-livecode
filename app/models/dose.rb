class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :cocktail
  # validates for dose presence
  validates :description, presence: true
  # validates for ingredient uniqueness per cocktail
  validates :ingredient, uniqueness: {scope: :cocktail}
end
