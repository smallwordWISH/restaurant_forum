class Admin::CategoriesController < Admin::BaseController
  
  before_action :set_category , only: [ :update, :destroy ]

  def index
    @categories = Category.order(created_at: :asc).all

    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "category was sucessfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.order(created_at: :asc).all
      render :index
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "category was sucessfully updated"
      redirect_to admin_categories_path
    else
      @categories = Category.order(created_at: :asc).all
      render :index
    end
  end

  def destroy
    @category.destroy

    if @category.errors 
      flash[:alert] = @category.errors.full_messages.to_sentence
    else
      flash[:notice] = "category was sucessfully deleted"
    end

    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
     @category = Category.find(params[:id])
  end

end
