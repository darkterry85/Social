class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
   
    def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 10) 
  end
end

def show
 @recipe = Recipe.find(params[:id])
end

def new
  @recipe = Recipe.new
end


def create
  
@recipe = Recipe.new(recipe_params)
@recipe.chef = Chef.find(1)

if @recipe.save
  flash[:success] = "Fashion was created succesfully!"
  redirect_to recipes_path
  

else 
  render :new
end

end

def edit
 @recipe = Recipe.find(params[:id]) 
end

def update
  @recipe = Recipe.find(params[:id])
  if @recipe.update(recipe_params)
    #do something
    flash[:success] = "Updated Succesfully"
    redirect_to recipe_path(@recipe)
  else
    render :edit
  end
end

def like
  @recipe = Recipe.find(params[:id])
  like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
  if like.valid?
  flash[:success] = "you liked this"
  redirect_to :back
else
  flash[:danger] = "You can only like or dislike once"
  redirect_to :back
end
end 

private

def recipe_params
params.require(:recipe).permit(:name, :summary, :description, :picture)
end

end