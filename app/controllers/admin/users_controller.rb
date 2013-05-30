class Admin::UsersController < Admin::BaseController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update user_params
    respond_with @user, location: edit_admin_user_path
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
