require "rest-client"

class PagesController < ApplicationController
	def index
		session[:img_array] = session[:img_array] || []

		if session[:img_array].empty? || params["button_action"] == "refresh"
			session[:img_array] = get_scryfall_images
		end

		session[:refresh_counter] = session[:refresh_counter] || 0

		if params["button_action"] == "refresh"
			session[:refresh_counter] +=1
		end

		@refresh_counter = session[:refresh_counter]
	end

	private

	def get_json(url)
		response = RestClient.get(url)
		JSON.parse(response)
	end

	def parse_cards(json, img_array)
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
			json = get_json(json["next_page"])
			parse_cards(json, img_array)
		end
	end

	def get_scryfall_images
		img_array = []
		
		api_url = "https://api.scryfall.com/cards/search?q="
		creature_search_array = ["merfolk", "goblin", "angel", "sliver"]
		creature_search_array.each do |creature_str|
			search_url = api_url + "type:legendary+type:" + creature_str
			json = get_json(search_url)
			parse_cards(json, img_array)

			sleep(0.1)
		end
		logger.debug(img_array)

		img_array.sample(9)
	end


end
