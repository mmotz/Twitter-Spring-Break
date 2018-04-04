require 'rubygems'
require 'oauth'
require 'json'

baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/user_timeline.json"
query   = URI.encode_www_form(
    "screen_name" => "",
#Insert Screen name above
    "count" => 5,
)
address = URI("#{baseurl}#{path}?#{query}")
request = Net::HTTP::Get.new address.request_uri

http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

consumer_key = OAuth::Consumer.new(
    "",
    "") 
#Insert API Key info above

access_token = OAuth::Token.new(
    "",
    "")
#Insert API acess token info above

request.oauth! http, consumer_key, access_token
http.start
response = http.request request

def print_timeline(tweets)
    tweets.each do |tweet| 
        puts tweet
        puts ""
    end
end

tweets = nil
if response.code == '200' then
  tweets = JSON.parse(response.body)
  print_timeline(tweets)
end