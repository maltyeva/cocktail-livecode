class DosesController < ApplicationController
  before_action :set_ingredient_and_cocktail, only: [:new, :create]

  def new
    # cocktails/34/doses/new
    @dose = Dose.new
  end

  def create
    # cocktails/34/doses
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    # find the dose
    @dose = Dose.find(params[:id])
    #find out what cocktail the dose belongs to
    @cocktail = @dose.cocktail
    #kill the dose
    @dose.destroy
    #redirect to another page
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def set_ingredient_and_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredients = Ingredient.all.order(name: :desc)
  end
end
