class Managers::ProductsController < Managers::ApplicationController


  def new
    @product = Product.new
    @disc = @product.discs.build
    @song = @disc.songs.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "商品情報の登録が完了しました"
      redirect_to managers_product_path(@product)
    else
      flash.now[:alert] = "商品情報の登録に失敗しました"
      render :new
    end
  end

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page]).per(5)
    @details = OrderDetail.where(product_id: @product.id)
  end



  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "商品情報の更新が完了しました"
      redirect_to managers_products_path
    else
      flash.now[:alert] = "商品情報の更新に失敗しました"
      render :edit
    end
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
    redirect_to managers_product_path(@product.id)
   else
    render :edit
   end
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

  def arrival_params
    params.require(:arrival).permit(:quantity, :product_id)
  end
end
