class Link < ApplicationRecord
  validate :valid_url

  def short
    Hashid.encode(self.id)
  end

  def valid_url
    Rails.logger.info("me")
    Rails.logger.info(url)
    
    uri = URI.parse(url)

    if uri.is_a?(URI::HTTP) && !uri.host.nil?
      return true
    else
      errors.add(:base, 'Needs to be a valid url')
      return false
    end
    
  end
end
