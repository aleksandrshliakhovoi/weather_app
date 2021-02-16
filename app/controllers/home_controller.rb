class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=80014&distance=0&API_KEY=BAC763AF-F21B-40D8-AA7B-3CB2EAED5765'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    #@final_output = @output[0]['AQI']
    #Check for empty results
    # if @output.empty?
    #   @final_output = "Error"
    # elsif !@output
    #   @final_output = "Error"
    # else
    #   @final_output = @output[0]['AQI']
    # end
    
    @final_output = @output[0]['AQI']

    if @final_output <= 50 
      @api_color = 'green'
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = 'yellow'
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = 'orange'
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = 'red'
    elsif @final_output >= 201
      @api_color = 'purple'
    end 
  end
end
