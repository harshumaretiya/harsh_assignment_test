class UserService
  def initialize(params = {})
    @params = params
  end

  def create_user
    user = User.new(@params)
    if user.save
      user
    else
      raise CustomError.new(user.errors.full_messages.to_sentence)
    end
  end

  def filter_users_by_campaigns(campaign_names, page, per_page)
    campaign_names_query = campaign_names.map { |name| "+\"#{name}\"" }.join(' ')
    query = User.where("MATCH(generated_campaign_name) AGAINST (? IN BOOLEAN MODE)", campaign_names_query)
    query.page(page).per(per_page)
  end
end
