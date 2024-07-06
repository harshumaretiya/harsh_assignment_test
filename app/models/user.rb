class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :campaigns_list_format

  private

  def campaigns_list_format
    return if campaigns_list.is_a?(Array) && campaigns_list.all? { |campaign| campaign.is_a?(Hash) && campaign.key?('campaign_name') && campaign.key?('campaign_id') }

    errors.add(:campaigns_list, 'must be an array of objects with campaign_name and campaign_id')
  end
end
