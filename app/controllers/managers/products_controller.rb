class Managers::ProductsController < Managers::ApplicationController


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
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page]).per(5)
  end

  private

  def search_params
    params.require(:q).permit(:name_cont)
  end

  def product_params
    params.require(:product).permit(:name, :price, :image, :release_date, :status,
                                    :description, :artist_id, :categorie_id, :company_id,
                                    discs_attributes: [:id, :sequence, :_destroy,
                                    songs_attributes: [:id, :name, :sequence, :_destroy]])
  end
end
