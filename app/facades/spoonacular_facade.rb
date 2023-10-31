class SpoonacularFacade
  def self.get_teas(query)
    teas = SpoonacularService.search_for_tea(query)
    teas[:searchResults].flat_map do |tea|
      tea[:results].map do |result|
        TeaResults.new(result)
      end
    end
  end
end
