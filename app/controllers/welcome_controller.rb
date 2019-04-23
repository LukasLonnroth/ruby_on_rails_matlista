require 'rest-client'
require 'rubygems'
require 'json'

class WelcomeController < ApplicationController
  def index
    begin
      response = RestClient.get('https://www.amica.fi/modules/json/json/Index?costNumber=3003&language=sv-FI')
      json = JSON.parse(response)
      menusForDays = json['MenusForDays']
      today = menusForDays[0]
      setmenus = today['SetMenus']
      todayString = ""

      for value in setmenus
        components = value['Components']
        for value in components
          todayString = todayString + value + '<br>'
        end
      end
      @arcadaResponse = todayString
      @arcadaOpen = menusForDays[0]['LunchTime']
    rescue NoMethodError
      @arcadaResponse = "Error when fetching data"
      @arcadaOpen = "Closed"
    end

    begin
      response = RestClient.get('https://api.citybik.es/v2/networks/citybikes-helsinki')
      json = JSON.parse(response)
      stations = json['network']['stations']

      @arabiaBikes = stations[270]['free_bikes']
      @arabiaSlots = stations[270]['free_bikes'] + stations[270]['empty_slots']
      @diakBikes = stations[210]['free_bikes']
      @diakSlots = stations[210]['free_bikes'] + stations[210]['empty_slots']
    rescue NoMethodError
      @arcadaResponse = "Error when fetching data"
      @arcadaOpen = "Closed"
    end

    begin
      response = RestClient.get('https://www.fazerfoodco.fi/modules/json/json/Index?costNumber=3104&language=sv-FI')
      json = JSON.parse(response)
      menusForDays = json['MenusForDays']
      today = menusForDays[0]
      setmenus = today['SetMenus']
      todayString = ""

      for value in setmenus
        components = value['Components']
        for value in components
          todayString = todayString + value + '<br>'
        end
      end
      @diakResponse = todayString
      @diakOpen = menusForDays[0]['LunchTime']
    rescue NoMethodError
      @diakResponse = "Error when fetching data"
      @diakOpen = "Closed"
    end

  end
end
