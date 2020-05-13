module PunkApiQueryService
	def self.get_json(url)
		response = RestClient.get(url)
		JSON.parse(response)
	end

	def self.get_punk_api()
		url = "https://api.punkapi.com/v2/beers?page=1&per_page=15"
		json = self.get_json(url)
		beers = json.map{ |beer|
			if beer["image_url"]
				{
					"id" => beer["id"],
					"name" => beer["name"],
					"description" => beer["description"],
					"image" => beer["image_url"],
					"food_pairing" => beer["food_pairing"]
				}
			end
		}

		beers.sample(9)
	end
end