class Site::HomeController < ApplicationController
  layout "site"

  def index
    @categories = Category.all
    @ads = Ad.limit(5).order(created_at: :desc)
  end
end
