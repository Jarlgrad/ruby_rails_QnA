require_relative "../services/punkapi_query_service"

class BeersController < ApplicationController
	def index	
		@beers ||= []
		if @beers.empty?
			@beers = PunkApiQueryService.get_punk_api()
		end
	end
	private
end