require 'msgpack'
require 'open-uri'
require 'digest/sha2'
require 'openssl'
require 'json'
require 'base64'

module Net
  class HTTP
    alias_method :original_use_ssl=, :use_ssl=
    def use_ssl=(flag)
      self.ca_file = Rails.root.join('lib/ca-bundle.crt').to_s
      self.verify_mode = OpenSSL::SSL::VERIFY_PEER
      self.original_use_ssl = flag
    end
  end
end

class PatrickIDConsumer
  
  def initialize(auth_server, service_id, shared_secret)
    @auth_server = auth_server
    @service_id = service_id
    @shared_secret = shared_secret
      puts "---"
      puts "Server  #{ auth_server }"
      puts "Service #{ service_id }"
      puts "Secret  #{ shared_secret }"
      puts "---"
  end
  
  def login_url(return_url, cancel_url = "/")
    puts CGI::escape(@auth_server)
    puts CGI::escape(@service_id)
    puts CGI::escape(return_url)
    puts CGI::escape(cancel_url)
    "https://#{ @auth_server }/authenticate?service=#{ CGI::escape(@service_id) }&returnURL=#{ CGI::escape(return_url) }&cancelURL=#{ CGI::escape(cancel_url) }"
  end
  
  def retrieve_token_url(token_id)
    "https://#{ @auth_server }/authorize/token?token=#{ CGI::escape(token_id) }&service=#{ CGI::escape(@service_id) }"
  end
  
  def retrieve_details(token_id)
    m = open(retrieve_token_url(token_id)).read
    begin
      res = MessagePack.unpack(m)
      res = decrypt_payload Base64.decode64(res['payload']), Base64.decode64(res['iv'])
      res = JSON.parse(res)
      res = nil unless res['application'] == @service_id
      res
      # check created_at timestamp, if unreasonable then 
    rescue
      nil
    end
  end
  
  def decrypt_payload(payload, iv)
    c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    c.decrypt
    c.key = key = OpenSSL::Digest::SHA512.new(@shared_secret).digest
    c.iv = iv
    d = c.update(payload)
    d << c.final
    d
  end
  
end





