class UsersController < ApplicationController
  # GET /users
  def index
    @users = User.page(params[:page]).per(params[:per_page])
    json_response(format_users(@users), pagination_meta(@users))
  end

  # POST /users
  def create
    user_service = UserService.new(user_params)
    @user = user_service.create_user
    json_response(UserSerializer.new(@user).serializable_hash[:data][:attributes], :created)
  end

  # GET /users/filter
  def filter
    campaign_names = params[:campaign_names].split(',')
    user_service = UserService.new
    @users = user_service.filter_users_by_campaigns(campaign_names, params[:page], params[:per_page])
    json_response(format_users(@users), pagination_meta(@users))
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, campaigns_list: [:campaign_name, :campaign_id])
  end

  def format_users(users)
    users.map { |user| UserSerializer.new(user).serializable_hash[:data][:attributes] }
  end


  def pagination_meta(users)
    {
      current_page: users.current_page,
      next_page: users.next_page,
      prev_page: users.prev_page,
      total_pages: users.total_pages,
      total_count: users.total_count
    }
  end
end
