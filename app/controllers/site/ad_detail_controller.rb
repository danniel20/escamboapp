class Site::AdDetailController < SiteController

  def show
  	@categories = Category.all
  	@ad = Ad.find(params[:id])
  end

end
