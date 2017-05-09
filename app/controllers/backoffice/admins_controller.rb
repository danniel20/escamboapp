class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  after_action :verify_authorized, only: [:new, :destroy]
  after_action :verify_policy_scoped, only: :index

  def index
    #@admins = Admin.all
    #@admins = Admin.with_full_access
    @admins = policy_scope(Admin)
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to(backoffice_admins_path, notice: I18n.t('messages.created_with', item: @admin.name))
    else
      render :new
    end

  end

  def edit

  end

  def update
    if @admin.update(params_admin)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to(backoffice_admins_path, notice: I18n.t('messages.updated_with', item: @admin.name))
    else
      render :edit
    end
  end

  def destroy
    authorize @admin
    admin_name = @admin.name

    admin_email = @admin.email

    if @admin.destroy
      redirect_to(backoffice_admins_path, notice: I18n.t('messages.destroyed_with', item: @admin.name))
    else
      render :index
    end

  end

  private

    def set_admin
      @admin = Admin.find(params[:id])
    end

    def params_admin
      if password_blank?
        params[:admin].except!(:password, :password_confirmation)
      end

      params.require(:admin).permit(policy(@admin).permitted_attributes)
    end


    def password_blank?
      params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
    end
end
