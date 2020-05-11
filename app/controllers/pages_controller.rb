require "rest-client"
require_relative "../services/scryfall_query_service"
require_relative "../services/starwars_query_service"

class PagesController < ApplicationController
	def index
		# session[:img_array] = session[:img_array] || []
		session[:img_array] ||= []

		if session[:img_array].empty? || params["button_action"] == "refresh"
			# scryfall_query_service = ScryfallQueryService.new
			
			# session[:img_array] = scryfall_query_service.get_scryfall_images
			session[:img_array] = ScryfallQueryService.get_scryfall_images
		end

		session[:refresh_counter] = session[:refresh_counter] || 0

		if params["button_action"] == "refresh"
			session[:refresh_counter] +=1
		end

		@refresh_counter = session[:refresh_counter]
	end

	private



end
