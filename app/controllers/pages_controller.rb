require_relative "../services/scryfall_query_service"
require_relative "../services/starwars_query_service"

class PagesController < ApplicationController

	def mtg
		update_session("mtg")
		@refresh_counter = session[:refresh_counter]
	end

	def swccg
		update_session("swccg")
		@refresh_counter = session[:refresh_counter]
	end

	private 

	def update_session(current_game)
		if session[:game] != current_game || !session[:game]
			session[:img_array] = []
			session[:game] = current_game
		end

		session[:img_array] ||= []

		if session[:img_array].empty? || params["button_action"] == "refresh"
			if current_game == "swccg"
				session[:img_array] = StarWarsQueryService.get_swccgdb_images
			
			elsif current_game == "mtg"
				session[:img_array] = ScryfallQueryService.get_scryfall_images
			end
		end

		session[:refresh_counter] ||= 0

		if params["button_action"] == "refresh"
			session[:refresh_counter] += 1
		end

	end
end
