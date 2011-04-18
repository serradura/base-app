class Admin::UsersController < Admin::BaseController

  helper_method :sort_column, :sort_direction

  before_filter :find_user, :only => [:edit, :update, :show, :destroy]

  def index
    @users = User.order(sort_column + " " + sort_direction)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => "User successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, :notice => "User deleted."
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "email"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end