class SpoonacularService

  def self.search_for_tea(query)
    get_url("/food/search?query=#{query}")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.spoonacular.com') do |f|
      f.headers['x-api-key'] = Rails.application.credentials.spoonacular[:key]
    end
  end
end