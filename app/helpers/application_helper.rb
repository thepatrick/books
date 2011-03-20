module ApplicationHelper
  
  def consumer
    return nil if ENV['PATRICKID_SERVER'].nil?
    @consumer ||= PatrickIDConsumer.new(ENV['PATRICKID_SERVER'], ENV['PATRICKID_SERVICEID'], ENV['PATRICKID_SECRET'])
  end
  
  def magic_login_url
    consumer && consumer.login_url('/loginWithToken') || login_path
  end
end
