class Backoffice::SendMailController < BackofficeController
  
  def edit
    @admin = Admin.find(params[:id])

  	respond_to do |format|
  	  format.js
  	end
  end

  def create
  	
  end

end
