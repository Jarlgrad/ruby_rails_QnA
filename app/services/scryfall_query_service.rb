module ScryfallQueryService 
	
	def self.get_json(url)
	response = RestClient.get(url)
	JSON.parse(response)
	end

	def self.parse_cards(json, img_array)
		data_array = json["data"]
		data_array.each do |card_hash|
			if card_hash["image_uris"]
				img_hash = {
					"image" => card_hash["image_uris"]["art_crop"],
					"name" => card_hash["name"],
					"artist" => card_hash["artist"]
				}
				img_array << img_hash
			end
		end

		if json["next_page"]
			json = self.get_json(json["next_page"])
			self.parse_cards(json, img_array)
		end
	end

	def self.get_scryfall_images
		img_array = []

		api_url = "https://api.scryfall.com/cards/search?q="
		creature_search_array = ["merfolk", "goblin", "angel", "sliver"]
		creature_search_array.each do |creature_str|
			search_url = api_url + "type:legendary+type:" + creature_str
			json = self.get_json(search_url)
			self.parse_cards(json, img_array)

			sleep(0.1)
		end

		img_array.sample(9)
	end
end