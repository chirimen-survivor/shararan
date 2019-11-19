class Managers::AccsController < Managers::ApplicationController
  skip_before_action :authenticate_manager!, only: [:index, :show, :new, :create, :edit, :update] # 後で消す

  def new
    @artist = Artist.new
    @categorie = Categorie.new
    @company = Company.new
  end

  def create
    if !params[:artist].nil?
      @artist = Artist.new(artist_params)
      @artist.save
      redirect_to new_managers_product_path
    elsif !params[:categorie].nil?
      @categorie = Categorie.new(categorie_params)
      @categorie.save
      redirect_to new_managers_product_path
    else
      @company = Company.new(company_params)
      @campany.save
      redirect_to new_managers_product_path
    end
  end

  def edit
    @artist = Artist.find(params[:id])
    @categorie = Categorie.find(params[:id])
    @company = Company.find(params[:id])
  end

  def update
    if !params[:artist].nil?
      @artist = Artist.find(params[:id])
      @artist.update
      redirect_to new_managers_product_path
    elsif !params[:categorie].nil?
      @categorie = Categorie.find(params[:id])
      @categorie.update
      redirect_to new_managers_product_path
    else
      @company = Company.find(params[:id])
      @campany.update
      redirect_to new_managers_product_path
    end
  end

  def destroy
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end

  def categorie_params
    params.require(:categorie).permit(:name)
  end

  def company_params
    params.require(:company).permit(:name)
  end

end
