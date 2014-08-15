require 'sinatra'
require 'yelp'
require 'json'
require 'oauth'
require 'pry-byebug'
require 'shotgun'
set :bind, '0.0.0.0'
# use Rack::Flash

get "/" do 
  @restaurant = nil
  @bar        = nil
  erb :index
end

post "/randomrestaurant" do
  # binding.pry

  data = {
    term: params["Restaurant"],
    limit: 3
  }

  p data

  # client = Yelp::Client.new({ consumer_key: "q_5VHCkxQcT1B4hxcCM_2w",
  #                             consumer_secret: "4HOFnWO9NT0anZexVqmiVyKzp5Q",
  #                             token: "udKMZsaQQ5B3UuXNob4jHtOuzPW4scNl",
  #                             token_secret: "qXl5GqbmqxR-Mk6J9QuCen-84Bc"
  #                           })

  consumer_key = "q_5VHCkxQcT1B4hxcCM_2w"
  consumer_secret = "4HOFnWO9NT0anZexVqmiVyKzp5Q"
  token = "udKMZsaQQ5B3UuXNob4jHtOuzPW4scNl"
  token_secret = "qXl5GqbmqxR-Mk6J9QuCen-84Bc"

  styles = [
    "sushi", "thai", "mexican", "pizza", "burgers",
    "hotdogs", "american", "deli", "italian", "chinese",
    "french", "bar", "irish", "vegetarian", "vegan",
    "sandwiches", "tacos", "beer", "texmex", "chinese", 
    "barbeque", "seafood", "steakhouses", "asianfusion"
  ]

  random_choice = styles.shuffle.first
  random_path = "/v2/search?term=bar+#{random_choice}&location=austin"

  # user_path = "/v2/search?term=restaurants+#{params['Restaurant']}&location=austin"

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://api.yelp.com"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)

  @search_response = JSON(access_token.get(random_path).body)
  @restaurant = @search_response["businesses"].shuffle.first

  # @restaurant = search_response['businesses'].first['name']
  # @url = search_response['businesses'].first['url']

  # "<a href='#{search_response['businesses'].first['url']}'>#{search_response['businesses'].first['name']}</a>"

  # response = client.search('Austin', data)#, { lang: 'en' })
  # search_results = JSON.parse(response.to_json)
  # first_name = search_results["businesses"].first["name"]
  # first_url = search_results["businesses"].first["url"]

  # @restaurant = first_name
  # @url = first_url

  erb :index
end

post "/randombar" do
  # binding.pry

  data = {
    term: params["bar"],
    limit: 3
  }

  p data

  # client = Yelp::Client.new({ consumer_key: "q_5VHCkxQcT1B4hxcCM_2w",
  #                             consumer_secret: "4HOFnWO9NT0anZexVqmiVyKzp5Q",
  #                             token: "udKMZsaQQ5B3UuXNob4jHtOuzPW4scNl",
  #                             token_secret: "qXl5GqbmqxR-Mk6J9QuCen-84Bc"
  #                           })

  consumer_key = "q_5VHCkxQcT1B4hxcCM_2w"
  consumer_secret = "4HOFnWO9NT0anZexVqmiVyKzp5Q"
  token = "udKMZsaQQ5B3UuXNob4jHtOuzPW4scNl"
  token_secret = "qXl5GqbmqxR-Mk6J9QuCen-84Bc"

  styles = [
    "sushi", "thai", "mexican", "pizza", "burgers",
    "hotdogs", "american", "deli", "italian", "chinese",
    "french", "bar", "irish", "vegetarian", "vegan",
    "sandwiches", "tacos", "beer", "texmex", "chinese", 
    "barbeque", "seafood", "steakhouses", "asianfusion"
  ]

  random_choice = styles.shuffle.first
  random_path = "/v2/search?term=bar+#{random_choice}&location=austin"

  # user_path = "/v2/search?term=bar+#{params['Restaurant']}&location=austin"

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://api.yelp.com"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)

  @search_response = JSON(access_token.get(random_path).body)
  @restaurant = @search_response["businesses"].shuffle.first

  # @restaurant = search_response['businesses'].first['name']
  # @url = search_response['businesses'].first['url']

  # "<a href='#{search_response['businesses'].first['url']}'>#{search_response['businesses'].first['name']}</a>"

  # response = client.search('Austin', data)#, { lang: 'en' })
  # search_results = JSON.parse(response.to_json)
  # first_name = search_results["businesses"].first["name"]
  # first_url = search_results["businesses"].first["url"]

  # @restaurant = first_name
  # @url = first_url

  erb :index
end
