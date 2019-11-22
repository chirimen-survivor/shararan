class Managers::ProductsController < Managers::ApplicationController
# skip_before_action :authenticate_customer!, only: [:index, :show, :new, :create, :exit]


  def new
    @product = Product.new
    @disc = @product.discs.build
    @song = @disc.songs.build
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to managers_product_path(@product)

  end

  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page]).per(5)
  end

  def edit
    @product = Product.find(params[:id])
    @arrival = Arrival.new
    @arrival.product_id = @product.id
  end

  def arrival_save
   @product = Product.find(params[:id])
   @arrival = Arrival.new(arrival_params)
   @arrival.product_id = @product.id
   if @arrival.save
    @product = Product.find(params[:id])
    redirect_to managers_product_path(@product.id)
   else
    @product = Product.find(params[:id])
    @arrival = Arrival.new(arrival_params)
    render :edit
   end
 end

  private

  def product_params
    params.require(:product).permit(:name, :price, :image, :release_date, :status,
                                    :description, :artist_id, :categorie_id, :company_id,
                                    discs_attributes: [:id, :sequence, :_destroy,
                                    songs_attributes: [:id, :name, :sequence, :_destroy]])
  end

  def arrival_params
    params.require(:arrival).permit(:quantity, :product_id)
  end
end
