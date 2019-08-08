class StaticController < ApplicationController
	def team
	end
	
	def contact
	end

	def welcome
	@first_name = params["first_name"]
	puts "ton first_name est params #{["first_name"]}"
	end
end